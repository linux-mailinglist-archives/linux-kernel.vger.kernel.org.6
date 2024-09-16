Return-Path: <linux-kernel+bounces-330880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A25FE97A5A2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4201A1F26200
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A348125777;
	Mon, 16 Sep 2024 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="hlTdFC3R"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE497158A1F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726502446; cv=none; b=ZKCoq2xUI2SVJFPQsLykbcnFgTPqo2HfGWKnD4vH2ZdmW39t/euW8x1ZhTz+zUJ1lxCQ/Ikd96M08tdrOTpMLMNiqe+aWZd319TUz9Vlr2q6/cbGpm55jSUcRx+GXC1a60uOJlcn3xu3uzv4u7E3cHQf+j0oBb9bz6Ou/V96Alc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726502446; c=relaxed/simple;
	bh=C/NhWVgXr5+OGORUHlYKFRWBAbdE39sGHZ0xgwz0Cx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R7COtMRBq7JQ4N+KjOzgZA6+OovqLw8eTnb6bRiDEPj/go8Bn8NNOINTJiPPlxnVkCkj87SAaOW5ximR++CQBfy9HkikrIjoQ0gp9xOONrooQw1NaQYJI6jbdZGX27CG3Bv7Ki7BIl4VLO/GHSbJa9NKlUHU8rQNfqBrCqjqE9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=hlTdFC3R; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7d21b0c8422so789286a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 09:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1726502437; x=1727107237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4l6PZHNgL7XaQ1gtuNa9Lx6+qcANDdwyGLJ4H3PGO5k=;
        b=hlTdFC3Re9LA+sWVb3yARc8clKEKjmXzq4QSpOQNo//PXUIQLHdFAPX9ntEa1V1cRr
         j/K477Xd2gxxnRKNe/SSkYqGaGwjoHhAEeOkI9PO+l8xf8uOwQTHOMKfXbcJCMa5E40w
         dWw5A6FCPgibkWvTmSdya58hNWJ5LPtWG+aL7azMvowhK4EPhDBz4MWGSAgBPsRdkm3B
         iBFM4SjNHlZBuEt+rvXhNcYtkLD+tIAGbzwndbJe8bP9cga10Dw4bSSf3QNIg3vHxIYf
         QgdLW1SFQMwT5Hxz8KdK8a3EmQTxgXXIbaHGsSSuU5ywftemhf2+c5Ntr2mfJCCjOJd7
         rvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726502437; x=1727107237;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4l6PZHNgL7XaQ1gtuNa9Lx6+qcANDdwyGLJ4H3PGO5k=;
        b=mnvVkIvKsPtNaJ5iHwtIt3fkoI+8gR/1NpWWxISf7j3uFfZIfQtZS+F9xTr8CKQ8Q1
         shmnRCBmdrqXTbOpStGuY0JeCuodXgtVZrvzBcozrWqpPfosrRBJLvzP5NSsFCu5MpgA
         l/aWlsPQieQXqH1OgSE/676MOncCN4UAMFEz+8ypTtFhyDgMxr6rRDbhZ0v+bJV8Clx5
         TqBEFNViwiFrlHd7krD81iGr3/lduGaxI14YUI79AeagCVPQIAfuGu0KOY8ydMWl//h9
         L7kLXSVqr6kcLmaHYGlIeyxLdTa3RbuBmrd/intI27GgHAgY5Zxigqn9LHbxgExmfJck
         B1Kg==
X-Gm-Message-State: AOJu0YwlGWEK+2NYAy1wt3DtFJfIaQio8O9iaEw/J32Cg6fm2mb1VCae
	jw3BvOVR5q6RUCnssZQq9hxwFSJGXsyaURbC7lw+pXBWni7IfTHevFqiP2ZwdEVbJnWQwmpfHGH
	/
X-Google-Smtp-Source: AGHT+IFHfeloSi2cLimUzL8VW6z0Bbn1zEw7ELT1WbpeGJDmgLSLp9qd2E92Si3k8jYa+jptXv2hIg==
X-Received: by 2002:a05:6a20:3d8f:b0:1cf:4fc0:4ad8 with SMTP id adf61e73a8af0-1cf75ef02aamr10572674637.6.1726502432977;
        Mon, 16 Sep 2024 09:00:32 -0700 (PDT)
Received: from ?IPV6:2001:56a:f979:1f00:d829:a1cb:f16d:c17b? ([2001:56a:f979:1f00:d829:a1cb:f16d:c17b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db49914fc9sm4440485a12.42.2024.09.16.09.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 09:00:32 -0700 (PDT)
Message-ID: <750fb856-9361-4d25-a9b9-efb728a35a5f@telus.net>
Date: Mon, 16 Sep 2024 10:00:30 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.11.0 crash on X startup
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: linux-kernel@vger.kernel.org
References: <96030dde-6c02-4308-b41b-48aeeba670f3@telus.net>
 <b955ec60-081d-4194-8688-b49ff206ea1d@telus.net>
 <aae5a0a4-4d65-43a0-a793-b95096e9ed98@telus.net> <ZugStvRPjdmQmMUx@gallifrey>
Content-Language: en-US
From: Bob Gill <gillb5@telus.net>
In-Reply-To: <ZugStvRPjdmQmMUx@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

OK.

  6.10.0.dmesg.txt:

[    0.000000] Linux version 6.10.0 (root@freedom) (gcc (Ubuntu 
11.4.0-1ubuntu1~22.04) 11.4.0, GNU ld (GNU Binutils for Ubuntu) 2.38) #1 
SMP PREEMPT_DYNAMIC Sun Jul 14 18:50:17 MDT 2024
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.10.0 
root=UUID=94072726-5fed-439f-a496-8e6aaa88617e ro quiet splash
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009e7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e800-0x000000000009ffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e4c00-0x00000000000fffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bf77ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bf780000-0x00000000bf797fff] 
ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000bf798000-0x00000000bf7dbfff] 
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bf7dc000-0x00000000bfffffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffe00000-0x00000000ffffffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000033fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] SMBIOS 2.5 present.
[    0.000000] DMI: System manufacturer System Product Name/P6T DELUXE, 
BIOS 2209    09/21/2010
[    0.000000] DMI: Memory slots populated: 6/6
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2672.822 MHz processor
[    0.001475] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.001480] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.001490] last_pfn = 0x340000 max_arch_pfn = 0x400000000
[    0.001500] total RAM covered: 12280M
[    0.001776] Found optimal setting for mtrr clean up
[    0.001778]  gran_size: 64K     chunk_size: 16M     num_reg: 6     
lose cover RAM: 0G
[    0.001785] MTRR map: 8 entries (5 fixed + 3 variable; max 21), built 
from 8 variable MTRRs
[    0.001788] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB WP  UC- WT
[    0.002782] e820: update [mem 0xbf800000-0xffffffff] usable ==> reserved
[    0.002795] last_pfn = 0xbf780 max_arch_pfn = 0x400000000
[    0.014817] found SMP MP-table at [mem 0x000ff780-0x000ff78f]
[    0.015274] RAMDISK: [mem 0x0c243000-0x37feefff]
[    0.015285] ACPI: Early table checksum verification disabled
[    0.015289] ACPI: RSDP 0x00000000000FB150 000024 (v02 ACPIAM)
[    0.015296] ACPI: XSDT 0x00000000BF780100 000064 (v01 092110 XSDT0924 
20100921 MSFT 00000097)
[    0.015305] ACPI: FACP 0x00000000BF780290 0000F4 (v03 092110 FACP0924 
20100921 MSFT 00000097)
[    0.015315] ACPI: DSDT 0x00000000BF7804B0 00B69B (v01 A1087 A1087001 
00000001 INTL 20060113)
[    0.015321] ACPI: FACS 0x00000000BF798000 000040
[    0.015326] ACPI: FACS 0x00000000BF798000 000040
[    0.015332] ACPI: APIC 0x00000000BF780390 0000D8 (v01 092110 APIC0924 
20100921 MSFT 00000097)
[    0.015338] ACPI: MCFG 0x00000000BF780470 00003C (v01 092110 OEMMCFG  
20100921 MSFT 00000097)
[    0.015344] ACPI: OEMB 0x00000000BF798040 000072 (v01 092110 OEMB0924 
20100921 MSFT 00000097)
[    0.015351] ACPI: HPET 0x00000000BF78F4B0 000038 (v01 092110 OEMHPET  
20100921 MSFT 00000097)
[    0.015356] ACPI: DMAR 0x00000000BF7980C0 000138 (v01 AMI OEMDMAR  
00000001 MSFT 00000097)
[    0.015363] ACPI: OSFR 0x00000000BF78F4F0 0000B0 (v01 092110 OEMOSFR  
20100921 MSFT 00000097)
[    0.015369] ACPI: SSDT 0x00000000BF799E10 000363 (v01 DpgPmm CpuPm    
00000012 INTL 20060113)
[    0.015374] ACPI: Reserving FACP table memory at [mem 
0xbf780290-0xbf780383]
[    0.015376] ACPI: Reserving DSDT table memory at [mem 
0xbf7804b0-0xbf78bb4a]
[    0.015378] ACPI: Reserving FACS table memory at [mem 
0xbf798000-0xbf79803f]
[    0.015380] ACPI: Reserving FACS table memory at [mem 
0xbf798000-0xbf79803f]
[    0.015381] ACPI: Reserving APIC table memory at [mem 
0xbf780390-0xbf780467]
[    0.015383] ACPI: Reserving MCFG table memory at [mem 
0xbf780470-0xbf7804ab]
[    0.015385] ACPI: Reserving OEMB table memory at [mem 
0xbf798040-0xbf7980b1]
[    0.015387] ACPI: Reserving HPET table memory at [mem 
0xbf78f4b0-0xbf78f4e7]
[    0.015389] ACPI: Reserving DMAR table memory at [mem 
0xbf7980c0-0xbf7981f7]
[    0.015391] ACPI: Reserving OSFR table memory at [mem 
0xbf78f4f0-0xbf78f59f]
[    0.015393] ACPI: Reserving SSDT table memory at [mem 
0xbf799e10-0xbf79a172]
[    0.015571] No NUMA configuration found
[    0.015573] Faking a node at [mem 0x0000000000000000-0x000000033fffffff]
[    0.015585] NODE_DATA(0) allocated [mem 0x33ffcd000-0x33fff7fff]
[    0.015976] Zone ranges:
[    0.015977]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.015981]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.015984]   Normal   [mem 0x0000000100000000-0x000000033fffffff]
[    0.015986]   Device   empty
[    0.015989] Movable zone start for each node
[    0.015992] Early memory node ranges
[    0.015993]   node   0: [mem 0x0000000000001000-0x000000000009dfff]
[    0.015996]   node   0: [mem 0x0000000000100000-0x00000000bf77ffff]
[    0.015998]   node   0: [mem 0x0000000100000000-0x000000033fffffff]
[    0.016003] Initmem setup node 0 [mem 
0x0000000000001000-0x000000033fffffff]
[    0.016010] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.016045] On node 0, zone DMA: 98 pages in unavailable ranges
[    0.043023] On node 0, zone Normal: 2176 pages in unavailable ranges
[    0.043321] ACPI: PM-Timer IO Port: 0x808
[    0.043351] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 
0-23
[    0.043359] IOAPIC[1]: apic_id 9, version 32, address 0xfec8a000, GSI 
24-47
[    0.043363] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.043367] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.043375] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.043377] ACPI: HPET id: 0x8086a301 base: 0xfed00000
[    0.043394] CPU topo: Max. logical packages:   2
[    0.043395] CPU topo: Max. logical dies:       2
[    0.043397] CPU topo: Max. dies per package:   1
[    0.043408] CPU topo: Max. threads per core:   2
[    0.043410] CPU topo: Num. cores per package:     4
[    0.043411] CPU topo: Num. threads per package:   8
[    0.043413] CPU topo: Allowing 8 present CPUs plus 8 hotplug CPUs
[    0.043430] PM: hibernation: Registered nosave memory: [mem 
0x00000000-0x00000fff]
[    0.043433] PM: hibernation: Registered nosave memory: [mem 
0x0009e000-0x0009efff]
[    0.043435] PM: hibernation: Registered nosave memory: [mem 
0x0009f000-0x0009ffff]
[    0.043437] PM: hibernation: Registered nosave memory: [mem 
0x000a0000-0x000e4fff]
[    0.043438] PM: hibernation: Registered nosave memory: [mem 
0x000e5000-0x000fffff]
[    0.043441] PM: hibernation: Registered nosave memory: [mem 
0xbf780000-0xbf797fff]
[    0.043443] PM: hibernation: Registered nosave memory: [mem 
0xbf798000-0xbf7dbfff]
[    0.043445] PM: hibernation: Registered nosave memory: [mem 
0xbf7dc000-0xbfffffff]
[    0.043446] PM: hibernation: Registered nosave memory: [mem 
0xc0000000-0xfedfffff]
[    0.043448] PM: hibernation: Registered nosave memory: [mem 
0xfee00000-0xfee00fff]
[    0.043450] PM: hibernation: Registered nosave memory: [mem 
0xfee01000-0xffdfffff]
[    0.043452] PM: hibernation: Registered nosave memory: [mem 
0xffe00000-0xffffffff]
[    0.043455] [mem 0xc0000000-0xfedfffff] available for PCI devices
[    0.043457] Booting paravirtualized kernel on bare hardware
[    0.043460] clocksource: refined-jiffies: mask: 0xffffffff 
max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.043470] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:16 
nr_cpu_ids:16 nr_node_ids:1
[    0.045161] percpu: Embedded 66 pages/cpu s233472 r8192 d28672 u524288
[    0.045176] pcpu-alloc: s233472 r8192 d28672 u524288 alloc=1*2097152
[    0.045181] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07
[    0.045194] pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15
[    0.045231] Kernel command line: BOOT_IMAGE=/vmlinuz-6.10.0 
root=UUID=94072726-5fed-439f-a496-8e6aaa88617e ro quiet splash
[    0.045361] Unknown kernel command line parameters "splash 
BOOT_IMAGE=/vmlinuz-6.10.0", will be passed to user space.
[    0.047509] Dentry cache hash table entries: 2097152 (order: 12, 
16777216 bytes, linear)
[    0.048620] Inode-cache hash table entries: 1048576 (order: 11, 
8388608 bytes, linear)
[    0.049016] Fallback order for Node 0: 0
[    0.049023] Built 1 zonelists, mobility grouping on.  Total pages: 
3143453
[    0.049025] Policy zone: Normal
[    0.049038] mem auto-init: stack:off, heap alloc:on, heap free:off
[    0.049053] software IO TLB: area num 16.
[    0.114306] Memory: 11519224K/12573812K available (20480K kernel 
code, 4232K rwdata, 7280K rodata, 4840K init, 5088K bss, 1054328K 
reserved, 0K cma-reserved)
[    0.125942] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.126139] Kernel/User page tables isolation: enabled
[    0.126276] ftrace: allocating 52778 entries in 207 pages
[    0.140436] ftrace: allocated 207 pages with 6 groups
[    0.141479] Dynamic Preempt: voluntary
[    0.141850] rcu: Preemptible hierarchical RCU implementation.
[    0.141852] rcu:     RCU restricting CPUs from NR_CPUS=8192 to 
nr_cpu_ids=16.
[    0.141854]     Trampoline variant of Tasks RCU enabled.
[    0.141855]     Rude variant of Tasks RCU enabled.
[    0.141856]     Tracing variant of Tasks RCU enabled.
[    0.141857] rcu: RCU calculated value of scheduler-enlistment delay 
is 25 jiffies.
[    0.141858] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
[    0.141884] RCU Tasks: Setting shift to 4 and lim to 1 
rcu_task_cb_adjust=1.
[    0.141889] RCU Tasks Rude: Setting shift to 4 and lim to 1 
rcu_task_cb_adjust=1.
[    0.141893] RCU Tasks Trace: Setting shift to 4 and lim to 1 
rcu_task_cb_adjust=1.
[    0.147869] NR_IRQS: 524544, nr_irqs: 960, preallocated irqs: 16
[    0.148139] rcu: srcu_init: Setting srcu_struct sizes based on 
contention.
[    0.148310] Console: colour dummy device 80x25
[    0.148314] printk: legacy console [tty0] enabled
[    0.148658] ACPI: Core revision 20240322
[    0.148976] clocksource: hpet: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 133484882848 ns
[    0.148993] APIC: Switch to symmetric I/O mode setup
[    0.148995] DMAR-IR: This system BIOS has enabled interrupt remapping
                on a chipset that contains an erratum making that
                feature unstable.  To maintain system stability
                interrupt remapping is being disabled.  Please
                contact your BIOS vendor for an update
[    0.149004] APIC: Switched APIC routing to: physical flat
[    0.149576] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.168993] clocksource: tsc-early: mask: 0xffffffffffffffff 
max_cycles: 0x2686f46da1a, max_idle_ns: 440795254728 ns
[    0.169002] Calibrating delay loop (skipped), value calculated using 
timer frequency.. 5345.64 BogoMIPS (lpj=10691288)
[    0.169030] CPU0: Thermal monitoring enabled (TM1)
[    0.169065] Last level iTLB entries: 4KB 512, 2MB 7, 4MB 7
[    0.169068] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.169073] process: using mwait in idle threads
[    0.169077] Spectre V1 : Mitigation: usercopy/swapgs barriers and 
__user pointer sanitization
[    0.169080] Spectre V2 : Mitigation: Retpolines
[    0.169081] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling 
RSB on context switch
[    0.169083] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    0.169085] Speculative Store Bypass: Vulnerable
[    0.169087] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    0.169089] MMIO Stale Data: Unknown: No mitigations
[    0.169093] x86/fpu: x87 FPU will use FXSAVE
[    0.201793] Freeing SMP alternatives memory: 44K
[    0.201814] pid_max: default: 32768 minimum: 301
[    0.202843] LSM: initializing 
lsm=lockdown,capability,landlock,apparmor,ima,evm
[    0.203140] landlock: Up and running.
[    0.203181] AppArmor: AppArmor initialized
[    0.203595] Mount-cache hash table entries: 32768 (order: 6, 262144 
bytes, linear)
[    0.203629] Mountpoint-cache hash table entries: 32768 (order: 6, 
262144 bytes, linear)
[    0.314378] smpboot: CPU0: Intel(R) Core(TM) i7 CPU 920  @ 2.67GHz 
(family: 0x6, model: 0x1a, stepping: 0x4)
[    0.314809] Performance Events: PEBS fmt1+, Nehalem events, 16-deep 
LBR, Intel PMU driver.
[    0.314837] core: CPU erratum AAJ80 worked around
[    0.314839] ... version:                3
[    0.314840] ... bit width:              48
[    0.314842] ... generic registers:      4
[    0.314843] ... value mask:             0000ffffffffffff
[    0.314845] ... max period:             000000007fffffff
[    0.314846] ... fixed-purpose events:   3
[    0.314848] ... event mask:             000000070000000f
[    0.315059] signal: max sigframe size: 1440
[    0.315088] Estimated ratio of average max frequency by base 
frequency (times 1024): 1075
[    0.316997] rcu: Hierarchical SRCU implementation.
[    0.316997] rcu:     Max phase no-delay instances is 1000.
[    0.317300] NMI watchdog: Enabled. Permanently consumes one hw-PMU 
counter.
[    0.317607] smp: Bringing up secondary CPUs ...
[    0.317828] smpboot: x86: Booting SMP configuration:
[    0.317831] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6 #7
[    0.329179] MDS CPU bug present and SMT on, data leak possible. See 
https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for 
more details.
[    0.334999] smp: Brought up 1 node, 8 CPUs
[    0.334999] smpboot: Total of 8 processors activated (42765.15 BogoMIPS)
[    0.337823] devtmpfs: initialized
[    0.337823] x86/mm: Memory block size: 128MB
[    0.342106] ACPI: PM: Registering ACPI NVS region [mem 
0xbf798000-0xbf7dbfff] (278528 bytes)
[    0.342106] clocksource: jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.342106] futex hash table entries: 4096 (order: 6, 262144 bytes, 
linear)
[    0.342106] pinctrl core: initialized pinctrl subsystem
[    0.342106] PM: RTC time: 15:52:09, date: 2024-09-16
[    0.342792] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.343173] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic 
allocations
[    0.343410] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for 
atomic allocations
[    0.343656] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for 
atomic allocations
[    0.343687] audit: initializing netlink subsys (disabled)
[    0.343710] audit: type=2000 audit(1726501929.192:1): 
state=initialized audit_enabled=0 res=1
[    0.345086] thermal_sys: Registered thermal governor 'fair_share'
[    0.345089] thermal_sys: Registered thermal governor 'bang_bang'
[    0.345090] thermal_sys: Registered thermal governor 'step_wise'
[    0.345091] thermal_sys: Registered thermal governor 'user_space'
[    0.345092] thermal_sys: Registered thermal governor 'power_allocator'
[    0.345108] EISA bus registered
[    0.345129] cpuidle: using governor ladder
[    0.345135] cpuidle: using governor menu
[    0.345199] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.345569] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) 
for domain 0000 [bus 00-ff]
[    0.345576] PCI: not using ECAM ([mem 0xe0000000-0xefffffff] not 
reserved)
[    0.345578] PCI: Using configuration type 1 for base access
[    0.345689] kprobes: kprobe jump-optimization is enabled. All kprobes 
are optimized if possible.
[    0.345689] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.345689] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.345689] Demotion targets for Node 0: null
[    0.345689] ACPI: Added _OSI(Module Device)
[    0.345689] ACPI: Added _OSI(Processor Device)
[    0.345689] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.345689] ACPI: Added _OSI(Processor Aggregator Device)
[    0.368869] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.409723] ACPI: Dynamic OEM Table Load:
[    0.409738] ACPI: SSDT 0xFFFF9CE580950000 001C0C (v01 DpgPmm P001Ist  
00000011 INTL 20060113)
[    0.411594] ACPI: _OSC evaluation for CPUs failed, trying _PDC
[    0.412180] ACPI: Interpreter enabled
[    0.412202] ACPI: PM: (supports S0 S1 S3 S4 S5)
[    0.412204] ACPI: Using IOAPIC for interrupt routing
[    0.412244] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) 
for domain 0000 [bus 00-ff]
[    0.413772] PCI: ECAM [mem 0xe0000000-0xefffffff] reserved as ACPI 
motherboard resource
[    0.413788] PCI: Using host bridge windows from ACPI; if necessary, 
use "pci=nocrs" and report a bug
[    0.413790] PCI: Using E820 reservations for host bridge windows
[    0.414017] ACPI: Enabled 13 GPEs in block 00 to 3F
[    0.424757] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.424765] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM 
ClockPM Segments MSI EDR HPX-Type3]
[    0.424772] acpi PNP0A08:00: _OSC: OS requested [PCIeHotplug 
SHPCHotplug PME AER PCIeCapability LTR DPC]
[    0.424775] acpi PNP0A08:00: _OSC: platform willing to grant 
[PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR DPC]
[    0.424777] acpi PNP0A08:00: _OSC: platform retains control of PCIe 
features (AE_NOT_FOUND)
[    0.425287] PCI host bridge to bus 0000:00
[    0.425291] pci_bus 0000:00: root bus resource [io 0x0000-0x0cf7 window]
[    0.425293] pci_bus 0000:00: root bus resource [io 0x0d00-0xffff window]
[    0.425295] pci_bus 0000:00: root bus resource [mem 
0x000a0000-0x000bffff window]
[    0.425297] pci_bus 0000:00: root bus resource [mem 
0x000d0000-0x000dffff window]
[    0.425299] pci_bus 0000:00: root bus resource [mem 
0xc0000000-0xdfffffff window]
[    0.425305] pci_bus 0000:00: root bus resource [mem 
0xf0000000-0xfed8ffff window]
[    0.425307] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.425334] pci 0000:00:00.0: [8086:3405] type 00 class 0x060000 PCIe 
Root Port
[    0.425363] pci 0000:00:00.0: enabling Extended Tags
[    0.425406] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
[    0.425512] pci 0000:00:01.0: [8086:3408] type 01 class 0x060400 PCIe 
Root Port
[    0.425529] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.425547] pci 0000:00:01.0: enabling Extended Tags
[    0.425593] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.425727] pci 0000:00:03.0: [8086:340a] type 01 class 0x060400 PCIe 
Root Port
[    0.425749] pci 0000:00:03.0: PCI bridge to [bus 02-04]
[    0.425753] pci 0000:00:03.0:   bridge window [io 0xa000-0xafff]
[    0.425756] pci 0000:00:03.0:   bridge window [mem 0xfb600000-0xfb8fffff]
[    0.425764] pci 0000:00:03.0:   bridge window [mem 
0xcfe00000-0xdfffffff 64bit pref]
[    0.425772] pci 0000:00:03.0: enabling Extended Tags
[    0.425817] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    0.425948] pci 0000:00:07.0: [8086:340e] type 01 class 0x060400 PCIe 
Root Port
[    0.425966] pci 0000:00:07.0: PCI bridge to [bus 05]
[    0.425983] pci 0000:00:07.0: enabling Extended Tags
[    0.426028] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    0.426156] pci 0000:00:14.0: [8086:342e] type 00 class 0x080000 PCIe 
Root Complex Integrated Endpoint
[    0.426266] pci 0000:00:14.1: [8086:3422] type 00 class 0x080000 PCIe 
Root Complex Integrated Endpoint
[    0.426377] pci 0000:00:14.2: [8086:3423] type 00 class 0x080000 PCIe 
Root Complex Integrated Endpoint
[    0.426481] pci 0000:00:14.3: [8086:3438] type 00 class 0x080000 
conventional PCI endpoint
[    0.426573] pci 0000:00:1a.0: [8086:3a37] type 00 class 0x0c0300 
conventional PCI endpoint
[    0.426615] pci 0000:00:1a.0: BAR 4 [io  0x9800-0x981f]
[    0.426743] pci 0000:00:1a.1: [8086:3a38] type 00 class 0x0c0300 
conventional PCI endpoint
[    0.426783] pci 0000:00:1a.1: BAR 4 [io  0x9880-0x989f]
[    0.426912] pci 0000:00:1a.2: [8086:3a39] type 00 class 0x0c0300 
conventional PCI endpoint
[    0.426953] pci 0000:00:1a.2: BAR 4 [io  0x9c00-0x9c1f]
[    0.427084] pci 0000:00:1a.7: [8086:3a3c] type 00 class 0x0c0320 
conventional PCI endpoint
[    0.427101] pci 0000:00:1a.7: BAR 0 [mem 0xfb5ff000-0xfb5ff3ff]
[    0.427183] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.427283] pci 0000:00:1b.0: [8086:3a3e] type 00 class 0x040300 PCIe 
Root Complex Integrated Endpoint
[    0.427301] pci 0000:00:1b.0: BAR 0 [mem 0xfb5f8000-0xfb5fbfff 64bit]
[    0.427377] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.427469] pci 0000:00:1c.0: [8086:3a40] type 01 class 0x060400 PCIe 
Root Port
[    0.427495] pci 0000:00:1c.0: PCI bridge to [bus 0a]
[    0.427509] pci 0000:00:1c.0:   bridge window [mem 
0xfaf00000-0xfaffffff 64bit pref]
[    0.427563] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.427689] pci 0000:00:1c.1: [8086:3a42] type 01 class 0x060400 PCIe 
Root Port
[    0.427715] pci 0000:00:1c.1: PCI bridge to [bus 09]
[    0.427721] pci 0000:00:1c.1:   bridge window [mem 0xfbc00000-0xfbdfffff]
[    0.427782] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.427904] pci 0000:00:1c.2: [8086:3a44] type 01 class 0x060400 PCIe 
Root Port
[    0.427931] pci 0000:00:1c.2: PCI bridge to [bus 08]
[    0.427935] pci 0000:00:1c.2:   bridge window [io 0xd000-0xdfff]
[    0.427939] pci 0000:00:1c.2:   bridge window [mem 0xfbb00000-0xfbbfffff]
[    0.427999] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.428131] pci 0000:00:1c.4: [8086:3a48] type 01 class 0x060400 PCIe 
Root Port
[    0.428157] pci 0000:00:1c.4: PCI bridge to [bus 07]
[    0.428162] pci 0000:00:1c.4:   bridge window [io 0xc000-0xcfff]
[    0.428165] pci 0000:00:1c.4:   bridge window [mem 0xfba00000-0xfbafffff]
[    0.428226] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.428356] pci 0000:00:1c.5: [8086:3a4a] type 01 class 0x060400 PCIe 
Root Port
[    0.428382] pci 0000:00:1c.5: PCI bridge to [bus 06]
[    0.428387] pci 0000:00:1c.5:   bridge window [io 0xb000-0xbfff]
[    0.428390] pci 0000:00:1c.5:   bridge window [mem 0xfb900000-0xfb9fffff]
[    0.428451] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.428579] pci 0000:00:1d.0: [8086:3a34] type 00 class 0x0c0300 
conventional PCI endpoint
[    0.428619] pci 0000:00:1d.0: BAR 4 [io  0x9080-0x909f]
[    0.428743] pci 0000:00:1d.1: [8086:3a35] type 00 class 0x0c0300 
conventional PCI endpoint
[    0.428784] pci 0000:00:1d.1: BAR 4 [io  0x9400-0x941f]
[    0.428910] pci 0000:00:1d.2: [8086:3a36] type 00 class 0x0c0300 
conventional PCI endpoint
[    0.428950] pci 0000:00:1d.2: BAR 4 [io  0x9480-0x949f]
[    0.429107] pci 0000:00:1d.7: [8086:3a3a] type 00 class 0x0c0320 
conventional PCI endpoint
[    0.429125] pci 0000:00:1d.7: BAR 0 [mem 0xfb5fe000-0xfb5fe3ff]
[    0.429207] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.429311] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401 
conventional PCI bridge
[    0.429336] pci 0000:00:1e.0: PCI bridge to [bus 0b] (subtractive decode)
[    0.429340] pci 0000:00:1e.0:   bridge window [io 0xe000-0xefff]
[    0.429344] pci 0000:00:1e.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    0.429471] pci 0000:00:1f.0: [8086:3a16] type 00 class 0x060100 
conventional PCI endpoint
[    0.429548] pci 0000:00:1f.0: quirk: [io  0x0800-0x087f] claimed by 
ICH6 ACPI/GPIO/TCO
[    0.429553] pci 0000:00:1f.0: quirk: [io  0x0500-0x053f] claimed by 
ICH6 GPIO
[    0.429557] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 
0294 (mask 0003)
[    0.429561] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 3 PIO at 
4700 (mask 001f)
[    0.429709] pci 0000:00:1f.2: [8086:3a22] type 00 class 0x010601 
conventional PCI endpoint
[    0.429723] pci 0000:00:1f.2: BAR 0 [io  0x8c00-0x8c07]
[    0.429731] pci 0000:00:1f.2: BAR 1 [io  0x8880-0x8883]
[    0.429738] pci 0000:00:1f.2: BAR 2 [io  0x8800-0x8807]
[    0.429745] pci 0000:00:1f.2: BAR 3 [io  0x8480-0x8483]
[    0.429752] pci 0000:00:1f.2: BAR 4 [io  0x8400-0x841f]
[    0.429760] pci 0000:00:1f.2: BAR 5 [mem 0xfb5fc000-0xfb5fc7ff]
[    0.429800] pci 0000:00:1f.2: PME# supported from D3hot
[    0.429900] pci 0000:00:1f.3: [8086:3a30] type 00 class 0x0c0500 
conventional PCI endpoint
[    0.429917] pci 0000:00:1f.3: BAR 0 [mem 0xfb5fd000-0xfb5fd0ff 64bit]
[    0.429937] pci 0000:00:1f.3: BAR 4 [io  0x0400-0x041f]
[    0.430038] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.430098] pci 0000:02:00.0: [1002:1478] type 01 class 0x060400 PCIe 
Switch Upstream Port
[    0.430113] pci 0000:02:00.0: BAR 0 [mem 0xfb6fc000-0xfb6fffff]
[    0.430129] pci 0000:02:00.0: PCI bridge to [bus 03-04]
[    0.430135] pci 0000:02:00.0:   bridge window [io 0xa000-0xafff]
[    0.430139] pci 0000:02:00.0:   bridge window [mem 0xfb700000-0xfb8fffff]
[    0.430149] pci 0000:02:00.0:   bridge window [mem 
0xcfe00000-0xdfffffff 64bit pref]
[    0.430234] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.430301] pci 0000:02:00.0: 16.000 Gb/s available PCIe bandwidth, 
limited by 5.0 GT/s PCIe x4 link at 0000:00:03.0 (capable of 63.012 Gb/s 
with 16.0 GT/s PCIe x4 link)
[    0.441019] pci 0000:00:03.0: PCI bridge to [bus 02-04]
[    0.441104] pci 0000:03:00.0: [1002:1479] type 01 class 0x060400 PCIe 
Switch Downstream Port
[    0.441132] pci 0000:03:00.0: PCI bridge to [bus 04]
[    0.441138] pci 0000:03:00.0:   bridge window [io 0xa000-0xafff]
[    0.441142] pci 0000:03:00.0:   bridge window [mem 0xfb700000-0xfb8fffff]
[    0.441152] pci 0000:03:00.0:   bridge window [mem 
0xcfe00000-0xdfffffff 64bit pref]
[    0.441238] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    0.441401] pci 0000:02:00.0: PCI bridge to [bus 03-04]
[    0.441464] pci 0000:04:00.0: [1002:743f] type 00 class 0x030000 PCIe 
Legacy Endpoint
[    0.441482] pci 0000:04:00.0: BAR 0 [mem 0xd0000000-0xdfffffff 64bit 
pref]
[    0.441494] pci 0000:04:00.0: BAR 2 [mem 0xcfe00000-0xcfffffff 64bit 
pref]
[    0.441502] pci 0000:04:00.0: BAR 4 [io  0xa000-0xa0ff]
[    0.441510] pci 0000:04:00.0: BAR 5 [mem 0xfb700000-0xfb7fffff]
[    0.441519] pci 0000:04:00.0: ROM [mem 0xfb8c0000-0xfb8dffff pref]
[    0.441556] pci 0000:04:00.0: Video device with shadowed ROM at [mem 
0x000c0000-0x000dffff]
[    0.441617] pci 0000:04:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.441688] pci 0000:04:00.0: 16.000 Gb/s available PCIe bandwidth, 
limited by 5.0 GT/s PCIe x4 link at 0000:00:03.0 (capable of 252.048 
Gb/s with 16.0 GT/s PCIe x16 link)
[    0.441789] pci 0000:04:00.1: [1002:ab28] type 00 class 0x040300 PCIe 
Legacy Endpoint
[    0.441804] pci 0000:04:00.1: BAR 0 [mem 0xfb8fc000-0xfb8fffff]
[    0.441902] pci 0000:04:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.442041] pci 0000:03:00.0: PCI bridge to [bus 04]
[    0.442104] pci 0000:00:07.0: PCI bridge to [bus 05]
[    0.442152] pci 0000:00:1c.0: PCI bridge to [bus 0a]
[    0.442220] pci 0000:09:00.0: [14f1:8880] type 00 class 0x040000 PCIe 
Endpoint
[    0.442254] pci 0000:09:00.0: BAR 0 [mem 0xfbc00000-0xfbdfffff 64bit]
[    0.442422] pci 0000:09:00.0: supports D1 D2
[    0.442424] pci 0000:09:00.0: PME# supported from D0 D1 D2 D3hot
[    0.442552] pci 0000:09:00.0: disabling ASPM on pre-1.1 PCIe device.  
You can enable it with 'pcie_aspm=force'
[    0.442566] pci 0000:00:1c.1: PCI bridge to [bus 09]
[    0.442643] pci 0000:08:00.0: [11ab:4364] type 00 class 0x020000 PCIe 
Legacy Endpoint
[    0.442670] pci 0000:08:00.0: BAR 0 [mem 0xfbbfc000-0xfbbfffff 64bit]
[    0.442682] pci 0000:08:00.0: BAR 2 [io  0xd800-0xd8ff]
[    0.442723] pci 0000:08:00.0: ROM [mem 0xfbbc0000-0xfbbdffff pref]
[    0.442794] pci 0000:08:00.0: supports D1 D2
[    0.442796] pci 0000:08:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.442894] pci 0000:00:1c.2: ASPM: current common clock 
configuration is inconsistent, reconfiguring
[    0.453025] pci 0000:00:1c.2: PCI bridge to [bus 08]
[    0.453118] pci 0000:07:00.0: [11ab:6121] type 00 class 0x01018f PCIe 
Legacy Endpoint
[    0.453139] pci 0000:07:00.0: BAR 0 [io  0xcc00-0xcc07]
[    0.453151] pci 0000:07:00.0: BAR 1 [io  0xc880-0xc883]
[    0.453162] pci 0000:07:00.0: BAR 2 [io  0xc800-0xc807]
[    0.453173] pci 0000:07:00.0: BAR 3 [io  0xc480-0xc483]
[    0.453185] pci 0000:07:00.0: BAR 4 [io  0xc400-0xc40f]
[    0.453196] pci 0000:07:00.0: BAR 5 [mem 0xfbaffc00-0xfbafffff]
[    0.453270] pci 0000:07:00.0: supports D1
[    0.453272] pci 0000:07:00.0: PME# supported from D0 D1 D3hot
[    0.453360] pci 0000:07:00.0: disabling ASPM on pre-1.1 PCIe device.  
You can enable it with 'pcie_aspm=force'
[    0.453372] pci 0000:00:1c.4: PCI bridge to [bus 07]
[    0.453445] pci 0000:06:00.0: [11ab:4364] type 00 class 0x020000 PCIe 
Legacy Endpoint
[    0.453472] pci 0000:06:00.0: BAR 0 [mem 0xfb9fc000-0xfb9fffff 64bit]
[    0.453484] pci 0000:06:00.0: BAR 2 [io  0xb800-0xb8ff]
[    0.453525] pci 0000:06:00.0: ROM [mem 0xfb9c0000-0xfb9dffff pref]
[    0.453597] pci 0000:06:00.0: supports D1 D2
[    0.453598] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.453702] pci 0000:00:1c.5: ASPM: current common clock 
configuration is inconsistent, reconfiguring
[    0.465025] pci 0000:00:1c.5: PCI bridge to [bus 06]
[    0.465059] pci_bus 0000:0b: extended config space not accessible
[    0.465104] pci 0000:0b:02.0: [1106:3044] type 00 class 0x0c0010 
conventional PCI endpoint
[    0.465122] pci 0000:0b:02.0: BAR 0 [mem 0xfbeff000-0xfbeff7ff]
[    0.465132] pci 0000:0b:02.0: BAR 1 [io  0xec00-0xec7f]
[    0.465203] pci 0000:0b:02.0: supports D2
[    0.465205] pci 0000:0b:02.0: PME# supported from D2 D3hot D3cold
[    0.465286] pci 0000:00:1e.0: PCI bridge to [bus 0b] (subtractive decode)
[    0.465296] pci 0000:00:1e.0:   bridge window [io 0x0000-0x0cf7 
window] (subtractive decode)
[    0.465298] pci 0000:00:1e.0:   bridge window [io 0x0d00-0xffff 
window] (subtractive decode)
[    0.465300] pci 0000:00:1e.0:   bridge window [mem 
0x000a0000-0x000bffff window] (subtractive decode)
[    0.465302] pci 0000:00:1e.0:   bridge window [mem 
0x000d0000-0x000dffff window] (subtractive decode)
[    0.465304] pci 0000:00:1e.0:   bridge window [mem 
0xc0000000-0xdfffffff window] (subtractive decode)
[    0.465306] pci 0000:00:1e.0:   bridge window [mem 
0xf0000000-0xfed8ffff window] (subtractive decode)
[    0.466214] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
[    0.466285] ACPI: PCI: Interrupt link LNKB configured for IRQ 5
[    0.466355] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    0.466425] ACPI: PCI: Interrupt link LNKD configured for IRQ 14
[    0.466495] ACPI: PCI: Interrupt link LNKE configured for IRQ 15
[    0.466564] ACPI: PCI: Interrupt link LNKF configured for IRQ 3
[    0.466634] ACPI: PCI: Interrupt link LNKG configured for IRQ 7
[    0.466703] ACPI: PCI: Interrupt link LNKH configured for IRQ 4
[    0.466879] iommu: Default domain type: Translated
[    0.466879] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.466879] SCSI subsystem initialized
[    0.466879] libata version 3.00 loaded.
[    0.466879] ACPI: bus type USB registered
[    0.466879] usbcore: registered new interface driver usbfs
[    0.466879] usbcore: registered new interface driver hub
[    0.466879] usbcore: registered new device driver usb
[    0.466879] pps_core: LinuxPPS API ver. 1 registered
[    0.466879] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 
Rodolfo Giometti <giometti@linux.it>
[    0.466879] PTP clock support registered
[    0.466879] EDAC MC: Ver: 3.0.0
[    0.466879] NetLabel: Initializing
[    0.466879] NetLabel:  domain hash size = 128
[    0.466879] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.466879] NetLabel:  unlabeled traffic allowed by default
[    0.466879] PCI: Using ACPI for IRQ routing
[    0.473633] PCI: Discovered peer bus ff
[    0.473635] PCI: root bus ff: using default resources
[    0.473637] PCI: Probing PCI hardware (bus ff)
[    0.473665] PCI host bridge to bus 0000:ff
[    0.473667] pci_bus 0000:ff: root bus resource [io 0x0000-0xffff]
[    0.473669] pci_bus 0000:ff: root bus resource [mem 
0x00000000-0xfffffffff]
[    0.473671] pci_bus 0000:ff: No busn resource found for root bus, 
will use [bus ff-ff]
[    0.473673] pci_bus 0000:ff: busn_res: can not insert [bus ff] under 
domain [bus 00-ff] (conflicts with (null) [bus 00-ff])
[    0.473681] pci 0000:ff:00.0: [8086:2c41] type 00 class 0x060000 
conventional PCI endpoint
[    0.473736] pci 0000:ff:00.1: [8086:2c01] type 00 class 0x060000 
conventional PCI endpoint
[    0.473787] pci 0000:ff:02.0: [8086:2c10] type 00 class 0x060000 
conventional PCI endpoint
[    0.473838] pci 0000:ff:02.1: [8086:2c11] type 00 class 0x060000 
conventional PCI endpoint
[    0.473888] pci 0000:ff:03.0: [8086:2c18] type 00 class 0x060000 
conventional PCI endpoint
[    0.473936] pci 0000:ff:03.1: [8086:2c19] type 00 class 0x060000 
conventional PCI endpoint
[    0.473992] pci 0000:ff:03.4: [8086:2c1c] type 00 class 0x060000 
conventional PCI endpoint
[    0.474041] pci 0000:ff:04.0: [8086:2c20] type 00 class 0x060000 
conventional PCI endpoint
[    0.474089] pci 0000:ff:04.1: [8086:2c21] type 00 class 0x060000 
conventional PCI endpoint
[    0.474139] pci 0000:ff:04.2: [8086:2c22] type 00 class 0x060000 
conventional PCI endpoint
[    0.474186] pci 0000:ff:04.3: [8086:2c23] type 00 class 0x060000 
conventional PCI endpoint
[    0.474235] pci 0000:ff:05.0: [8086:2c28] type 00 class 0x060000 
conventional PCI endpoint
[    0.474283] pci 0000:ff:05.1: [8086:2c29] type 00 class 0x060000 
conventional PCI endpoint
[    0.474333] pci 0000:ff:05.2: [8086:2c2a] type 00 class 0x060000 
conventional PCI endpoint
[    0.474387] pci 0000:ff:05.3: [8086:2c2b] type 00 class 0x060000 
conventional PCI endpoint
[    0.474436] pci 0000:ff:06.0: [8086:2c30] type 00 class 0x060000 
conventional PCI endpoint
[    0.474486] pci 0000:ff:06.1: [8086:2c31] type 00 class 0x060000 
conventional PCI endpoint
[    0.474537] pci 0000:ff:06.2: [8086:2c32] type 00 class 0x060000 
conventional PCI endpoint
[    0.474585] pci 0000:ff:06.3: [8086:2c33] type 00 class 0x060000 
conventional PCI endpoint
[    0.474645] pci_bus 0000:ff: busn_res: [bus ff] end is updated to ff
[    0.474648] pci_bus 0000:ff: busn_res: can not insert [bus ff] under 
domain [bus 00-ff] (conflicts with (null) [bus 00-ff])
[    0.474656] PCI: pci_cache_line_size set to 64 bytes
[    0.474747] e820: reserve RAM buffer [mem 0x0009e800-0x0009ffff]
[    0.474749] e820: reserve RAM buffer [mem 0xbf780000-0xbfffffff]
[    0.474774] pci 0000:04:00.0: vgaarb: setting as boot VGA device
[    0.474774] pci 0000:04:00.0: vgaarb: bridge control possible
[    0.474774] pci 0000:04:00.0: vgaarb: VGA device added: 
decodes=io+mem,owns=io+mem,locks=none
[    0.474774] vgaarb: loaded
[    0.474774] hpet: 4 channels of 0 reserved for per-cpu timers
[    0.474774] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    0.474774] hpet0: 4 comparators, 64-bit 14.318180 MHz counter
[    0.477042] clocksource: Switched to clocksource tsc-early
[    0.477689] VFS: Disk quotas dquot_6.6.0
[    0.477745] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 
bytes)
[    0.477935] AppArmor: AppArmor Filesystem Enabled
[    0.477956] pnp: PnP ACPI init
[    0.478038] system 00:00: [mem 0xfbf00000-0xfbffffff] has been reserved
[    0.478046] system 00:00: [mem 0xfc000000-0xfcffffff] has been reserved
[    0.478049] system 00:00: [mem 0xfd000000-0xfdffffff] has been reserved
[    0.478051] system 00:00: [mem 0xfe000000-0xfebfffff] has been reserved
[    0.478053] system 00:00: [mem 0xfec8a000-0xfec8afff] could not be 
reserved
[    0.478055] system 00:00: [mem 0xfed10000-0xfed10fff] has been reserved
[    0.478391] system 00:02: [io  0x0290-0x029f] has been reserved
[    0.478663] system 00:03: [io  0x04d0-0x04d1] has been reserved
[    0.478667] system 00:03: [io  0x0800-0x087f] has been reserved
[    0.478670] system 00:03: [io  0x0500-0x057f] could not be reserved
[    0.478672] system 00:03: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.478675] system 00:03: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.478677] system 00:03: [mem 0xfed40000-0xfed8ffff] has been reserved
[    0.478835] system 00:04: [mem 0xffc00000-0xffdfffff] has been reserved
[    0.479008] system 00:05: [mem 0xfec00000-0xfec00fff] could not be 
reserved
[    0.479012] system 00:05: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.479171] system 00:06: [mem 0xe0000000-0xefffffff] has been reserved
[    0.479382] pnp 00:07: disabling [mem 0x000c0000-0x000cffff] because 
it overlaps 0000:04:00.0 BAR 6 [mem 0x000c0000-0x000dffff]
[    0.479416] system 00:07: [mem 0x00000000-0x0009ffff] could not be 
reserved
[    0.479420] system 00:07: [mem 0x000e0000-0x000fffff] could not be 
reserved
[    0.479422] system 00:07: [mem 0x00100000-0xbfffffff] could not be 
reserved
[    0.479424] system 00:07: [mem 0xfed90000-0xffffffff] could not be 
reserved
[    0.479590] pnp: PnP ACPI: found 8 devices
[    0.486044] clocksource: acpi_pm: mask: 0xffffff max_cycles: 
0xffffff, max_idle_ns: 2085701024 ns
[    0.486299] NET: Registered PF_INET protocol family
[    0.486552] IP idents hash table entries: 262144 (order: 9, 2097152 
bytes, linear)
[    0.490639] tcp_listen_portaddr_hash hash table entries: 8192 (order: 
5, 131072 bytes, linear)
[    0.490686] Table-perturb hash table entries: 65536 (order: 6, 262144 
bytes, linear)
[    0.490806] TCP established hash table entries: 131072 (order: 8, 
1048576 bytes, linear)
[    0.491208] TCP bind hash table entries: 65536 (order: 9, 2097152 
bytes, linear)
[    0.491508] TCP: Hash tables configured (established 131072 bind 65536)
[    0.491711] MPTCP token hash table entries: 16384 (order: 6, 393216 
bytes, linear)
[    0.491803] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.491874] UDP-Lite hash table entries: 8192 (order: 6, 262144 
bytes, linear)
[    0.492005] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.492014] NET: Registered PF_XDP protocol family
[    0.492029] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to 
[bus 0a] add_size 1000
[    0.492033] pci 0000:00:1c.0: bridge window [mem 
0x00100000-0x000fffff] to [bus 0a] add_size 200000 add_align 100000
[    0.492037] pci 0000:00:1c.1: bridge window [io  0x1000-0x0fff] to 
[bus 09] add_size 1000
[    0.492039] pci 0000:00:1c.1: bridge window [mem 
0x00100000-0x000fffff 64bit pref] to [bus 09] add_size 200000 add_align 
100000
[    0.492043] pci 0000:00:1c.2: bridge window [mem 
0x00100000-0x000fffff 64bit pref] to [bus 08] add_size 200000 add_align 
100000
[    0.492064] pci 0000:00:1c.4: bridge window [mem 
0x00100000-0x000fffff 64bit pref] to [bus 07] add_size 200000 add_align 
100000
[    0.492080] pci 0000:00:1c.5: bridge window [mem 
0x00100000-0x000fffff 64bit pref] to [bus 06] add_size 200000 add_align 
100000
[    0.492099] pci 0000:00:1c.0: bridge window [mem 
0xc0000000-0xc01fffff]: assigned
[    0.492103] pci 0000:00:1c.1: bridge window [mem 
0xc0200000-0xc03fffff 64bit pref]: assigned
[    0.492106] pci 0000:00:1c.2: bridge window [mem 
0xc0400000-0xc05fffff 64bit pref]: assigned
[    0.492109] pci 0000:00:1c.4: bridge window [mem 
0xc0600000-0xc07fffff 64bit pref]: assigned
[    0.492111] pci 0000:00:1c.5: bridge window [mem 
0xc0800000-0xc09fffff 64bit pref]: assigned
[    0.492115] pci 0000:00:1c.0: bridge window [io 0x1000-0x1fff]: assigned
[    0.492117] pci 0000:00:1c.1: bridge window [io 0x2000-0x2fff]: assigned
[    0.492120] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.492131] pci 0000:03:00.0: PCI bridge to [bus 04]
[    0.492133] pci 0000:03:00.0:   bridge window [io 0xa000-0xafff]
[    0.492139] pci 0000:03:00.0:   bridge window [mem 0xfb700000-0xfb8fffff]
[    0.492143] pci 0000:03:00.0:   bridge window [mem 
0xcfe00000-0xdfffffff 64bit pref]
[    0.492148] pci 0000:02:00.0: PCI bridge to [bus 03-04]
[    0.492151] pci 0000:02:00.0:   bridge window [io 0xa000-0xafff]
[    0.492156] pci 0000:02:00.0:   bridge window [mem 0xfb700000-0xfb8fffff]
[    0.492159] pci 0000:02:00.0:   bridge window [mem 
0xcfe00000-0xdfffffff 64bit pref]
[    0.492165] pci 0000:00:03.0: PCI bridge to [bus 02-04]
[    0.492167] pci 0000:00:03.0:   bridge window [io 0xa000-0xafff]
[    0.492171] pci 0000:00:03.0:   bridge window [mem 0xfb600000-0xfb8fffff]
[    0.492174] pci 0000:00:03.0:   bridge window [mem 
0xcfe00000-0xdfffffff 64bit pref]
[    0.492179] pci 0000:00:07.0: PCI bridge to [bus 05]
[    0.492187] pci 0000:00:1c.0: PCI bridge to [bus 0a]
[    0.492190] pci 0000:00:1c.0:   bridge window [io 0x1000-0x1fff]
[    0.492194] pci 0000:00:1c.0:   bridge window [mem 0xc0000000-0xc01fffff]
[    0.492197] pci 0000:00:1c.0:   bridge window [mem 
0xfaf00000-0xfaffffff 64bit pref]
[    0.492203] pci 0000:00:1c.1: PCI bridge to [bus 09]
[    0.492205] pci 0000:00:1c.1:   bridge window [io 0x2000-0x2fff]
[    0.492209] pci 0000:00:1c.1:   bridge window [mem 0xfbc00000-0xfbdfffff]
[    0.492213] pci 0000:00:1c.1:   bridge window [mem 
0xc0200000-0xc03fffff 64bit pref]
[    0.492218] pci 0000:00:1c.2: PCI bridge to [bus 08]
[    0.492221] pci 0000:00:1c.2:   bridge window [io 0xd000-0xdfff]
[    0.492225] pci 0000:00:1c.2:   bridge window [mem 0xfbb00000-0xfbbfffff]
[    0.492229] pci 0000:00:1c.2:   bridge window [mem 
0xc0400000-0xc05fffff 64bit pref]
[    0.492234] pci 0000:00:1c.4: PCI bridge to [bus 07]
[    0.492236] pci 0000:00:1c.4:   bridge window [io 0xc000-0xcfff]
[    0.492240] pci 0000:00:1c.4:   bridge window [mem 0xfba00000-0xfbafffff]
[    0.492244] pci 0000:00:1c.4:   bridge window [mem 
0xc0600000-0xc07fffff 64bit pref]
[    0.492249] pci 0000:00:1c.5: PCI bridge to [bus 06]
[    0.492252] pci 0000:00:1c.5:   bridge window [io 0xb000-0xbfff]
[    0.492256] pci 0000:00:1c.5:   bridge window [mem 0xfb900000-0xfb9fffff]
[    0.492259] pci 0000:00:1c.5:   bridge window [mem 
0xc0800000-0xc09fffff 64bit pref]
[    0.492265] pci 0000:00:1e.0: PCI bridge to [bus 0b]
[    0.492267] pci 0000:00:1e.0:   bridge window [io 0xe000-0xefff]
[    0.492272] pci 0000:00:1e.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    0.492279] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.492281] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.492283] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff 
window]
[    0.492285] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff 
window]
[    0.492287] pci_bus 0000:00: resource 8 [mem 0xc0000000-0xdfffffff 
window]
[    0.492288] pci_bus 0000:00: resource 9 [mem 0xf0000000-0xfed8ffff 
window]
[    0.492290] pci_bus 0000:02: resource 0 [io  0xa000-0xafff]
[    0.492292] pci_bus 0000:02: resource 1 [mem 0xfb600000-0xfb8fffff]
[    0.492294] pci_bus 0000:02: resource 2 [mem 0xcfe00000-0xdfffffff 
64bit pref]
[    0.492296] pci_bus 0000:03: resource 0 [io  0xa000-0xafff]
[    0.492297] pci_bus 0000:03: resource 1 [mem 0xfb700000-0xfb8fffff]
[    0.492299] pci_bus 0000:03: resource 2 [mem 0xcfe00000-0xdfffffff 
64bit pref]
[    0.492301] pci_bus 0000:04: resource 0 [io  0xa000-0xafff]
[    0.492303] pci_bus 0000:04: resource 1 [mem 0xfb700000-0xfb8fffff]
[    0.492304] pci_bus 0000:04: resource 2 [mem 0xcfe00000-0xdfffffff 
64bit pref]
[    0.492307] pci_bus 0000:0a: resource 0 [io  0x1000-0x1fff]
[    0.492308] pci_bus 0000:0a: resource 1 [mem 0xc0000000-0xc01fffff]
[    0.492310] pci_bus 0000:0a: resource 2 [mem 0xfaf00000-0xfaffffff 
64bit pref]
[    0.492312] pci_bus 0000:09: resource 0 [io  0x2000-0x2fff]
[    0.492314] pci_bus 0000:09: resource 1 [mem 0xfbc00000-0xfbdfffff]
[    0.492315] pci_bus 0000:09: resource 2 [mem 0xc0200000-0xc03fffff 
64bit pref]
[    0.492317] pci_bus 0000:08: resource 0 [io  0xd000-0xdfff]
[    0.492319] pci_bus 0000:08: resource 1 [mem 0xfbb00000-0xfbbfffff]
[    0.492321] pci_bus 0000:08: resource 2 [mem 0xc0400000-0xc05fffff 
64bit pref]
[    0.492322] pci_bus 0000:07: resource 0 [io  0xc000-0xcfff]
[    0.492324] pci_bus 0000:07: resource 1 [mem 0xfba00000-0xfbafffff]
[    0.492326] pci_bus 0000:07: resource 2 [mem 0xc0600000-0xc07fffff 
64bit pref]
[    0.492328] pci_bus 0000:06: resource 0 [io  0xb000-0xbfff]
[    0.492330] pci_bus 0000:06: resource 1 [mem 0xfb900000-0xfb9fffff]
[    0.492331] pci_bus 0000:06: resource 2 [mem 0xc0800000-0xc09fffff 
64bit pref]
[    0.492333] pci_bus 0000:0b: resource 0 [io  0xe000-0xefff]
[    0.492335] pci_bus 0000:0b: resource 1 [mem 0xfbe00000-0xfbefffff]
[    0.492337] pci_bus 0000:0b: resource 4 [io  0x0000-0x0cf7 window]
[    0.492338] pci_bus 0000:0b: resource 5 [io  0x0d00-0xffff window]
[    0.492340] pci_bus 0000:0b: resource 6 [mem 0x000a0000-0x000bffff 
window]
[    0.492342] pci_bus 0000:0b: resource 7 [mem 0x000d0000-0x000dffff 
window]
[    0.492344] pci_bus 0000:0b: resource 8 [mem 0xc0000000-0xdfffffff 
window]
[    0.492345] pci_bus 0000:0b: resource 9 [mem 0xf0000000-0xfed8ffff 
window]
[    0.492438] pci_bus 0000:ff: resource 4 [io  0x0000-0xffff]
[    0.492441] pci_bus 0000:ff: resource 5 [mem 0x00000000-0xfffffffff]
[    0.494335] pci 0000:04:00.1: D0 power state depends on 0000:04:00.0
[    0.494393] PCI: CLS 256 bytes, default 64
[    0.494465] DMAR: Host address width 39
[    0.494467] DMAR: DRHD base: 0x000000fbfff000 flags: 0x0
[    0.494479] DMAR: dmar0: reg_base_addr fbfff000 ver 1:0 cap 
c9008010e60262 ecap f0207a
[    0.494482] DMAR: DRHD base: 0x000000fbffe000 flags: 0x1
[    0.494490] DMAR: dmar1: reg_base_addr fbffe000 ver 1:0 cap 
c90780106f0462 ecap f020fe
[    0.494493] DMAR: RMRR base: 0x000000000ec000 end: 0x000000000effff
[    0.494495] DMAR: RMRR base: 0x000000bf7dc000 end: 0x000000bf7dbfff
[    0.494496] DMAR: [Firmware Bug]: Your BIOS is broken; bad RMRR 
[0x00000000bf7dc000-0x00000000bf7dbfff]
                BIOS vendor: American Megatrends Inc.; Ver: 2209 ; 
Product Version: System Version
[    0.494499] DMAR: ATSR flags: 0x0
[    0.494525] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.494526] software IO TLB: mapped [mem 
0x00000000bb780000-0x00000000bf780000] (64MB)
[    0.494529] Trying to unpack rootfs image as initramfs...
[    0.501232] Initialise system trusted keyrings
[    0.501252] Key type blacklist registered
[    0.501310] workingset: timestamp_bits=36 max_order=22 bucket_order=0
[    0.501320] zbud: loaded
[    0.502994] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.503171] fuse: init (API version 7.40)
[    0.503455] integrity: Platform Keyring initialized
[    0.520725] Key type asymmetric registered
[    0.520731] Asymmetric key parser 'x509' registered
[    0.520822] Block layer SCSI generic (bsg) driver version 0.4 loaded 
(major 243)
[    0.520947] io scheduler mq-deadline registered
[    0.523375] pcieport 0000:00:1c.0: enabling device (0106 -> 0107)
[    0.523584] pcieport 0000:00:1c.1: enabling device (0106 -> 0107)
[    0.524511] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.525249] input: Power Button as 
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.525293] ACPI: button: Power Button [PWRB]
[    0.525332] input: Power Button as 
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.525453] ACPI: button: Power Button [PWRF]
[    0.526153] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.530764] Linux agpgart interface v0.103
[    0.535409] loop: module loaded
[    0.535886] tun: Universal TUN/TAP device driver, 1.6
[    0.536003] PPP generic driver version 2.4.2
[    0.536339] VFIO - User Level meta-driver version: 0.3
[    0.536887] ehci-pci 0000:00:1a.7: EHCI Host Controller
[    0.536896] ehci-pci 0000:00:1a.7: new USB bus registered, assigned 
bus number 1
[    0.536908] ehci-pci 0000:00:1a.7: debug port 1
[    0.540833] ehci-pci 0000:00:1a.7: irq 18, io mem 0xfb5ff000
[    0.556823] ehci-pci 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    0.556921] usb usb1: New USB device found, idVendor=1d6b, 
idProduct=0002, bcdDevice= 6.10
[    0.556925] usb usb1: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    0.556927] usb usb1: Product: EHCI Host Controller
[    0.556929] usb usb1: Manufacturer: Linux 6.10.0 ehci_hcd
[    0.556930] usb usb1: SerialNumber: 0000:00:1a.7
[    0.557249] hub 1-0:1.0: USB hub found
[    0.557261] hub 1-0:1.0: 6 ports detected
[    0.557549] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    0.557564] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned 
bus number 2
[    0.557574] uhci_hcd 0000:00:1a.0: detected 2 ports
[    0.557608] uhci_hcd 0000:00:1a.0: irq 16, io port 0x00009800
[    0.557673] usb usb2: New USB device found, idVendor=1d6b, 
idProduct=0001, bcdDevice= 6.10
[    0.557676] usb usb2: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    0.557678] usb usb2: Product: UHCI Host Controller
[    0.557680] usb usb2: Manufacturer: Linux 6.10.0 uhci_hcd
[    0.557681] usb usb2: SerialNumber: 0000:00:1a.0
[    0.557929] hub 2-0:1.0: USB hub found
[    0.557941] hub 2-0:1.0: 2 ports detected
[    0.558087] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    0.558096] ehci-pci 0000:00:1d.7: new USB bus registered, assigned 
bus number 3
[    0.558110] ehci-pci 0000:00:1d.7: debug port 1
[    0.562039] ehci-pci 0000:00:1d.7: irq 23, io mem 0xfb5fe000
[    0.576813] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    0.576895] usb usb3: New USB device found, idVendor=1d6b, 
idProduct=0002, bcdDevice= 6.10
[    0.576898] usb usb3: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    0.576901] usb usb3: Product: EHCI Host Controller
[    0.576902] usb usb3: Manufacturer: Linux 6.10.0 ehci_hcd
[    0.576904] usb usb3: SerialNumber: 0000:00:1d.7
[    0.577196] hub 3-0:1.0: USB hub found
[    0.577207] hub 3-0:1.0: 6 ports detected
[    0.577405] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    0.577415] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned 
bus number 4
[    0.577424] uhci_hcd 0000:00:1a.1: detected 2 ports
[    0.577464] uhci_hcd 0000:00:1a.1: irq 21, io port 0x00009880
[    0.577527] usb usb4: New USB device found, idVendor=1d6b, 
idProduct=0001, bcdDevice= 6.10
[    0.577531] usb usb4: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    0.577533] usb usb4: Product: UHCI Host Controller
[    0.577534] usb usb4: Manufacturer: Linux 6.10.0 uhci_hcd
[    0.577536] usb usb4: SerialNumber: 0000:00:1a.1
[    0.577801] hub 4-0:1.0: USB hub found
[    0.577813] hub 4-0:1.0: 2 ports detected
[    0.578126] uhci_hcd 0000:00:1a.2: UHCI Host Controller
[    0.578132] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned 
bus number 5
[    0.578138] uhci_hcd 0000:00:1a.2: detected 2 ports
[    0.578162] uhci_hcd 0000:00:1a.2: irq 19, io port 0x00009c00
[    0.578224] usb usb5: New USB device found, idVendor=1d6b, 
idProduct=0001, bcdDevice= 6.10
[    0.578227] usb usb5: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    0.578229] usb usb5: Product: UHCI Host Controller
[    0.578230] usb usb5: Manufacturer: Linux 6.10.0 uhci_hcd
[    0.578232] usb usb5: SerialNumber: 0000:00:1a.2
[    0.578490] hub 5-0:1.0: USB hub found
[    0.578502] hub 5-0:1.0: 2 ports detected
[    0.578756] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    0.578762] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned 
bus number 6
[    0.578769] uhci_hcd 0000:00:1d.0: detected 2 ports
[    0.578786] uhci_hcd 0000:00:1d.0: irq 23, io port 0x00009080
[    0.578844] usb usb6: New USB device found, idVendor=1d6b, 
idProduct=0001, bcdDevice= 6.10
[    0.578848] usb usb6: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    0.578850] usb usb6: Product: UHCI Host Controller
[    0.578851] usb usb6: Manufacturer: Linux 6.10.0 uhci_hcd
[    0.578853] usb usb6: SerialNumber: 0000:00:1d.0
[    0.579102] hub 6-0:1.0: USB hub found
[    0.579113] hub 6-0:1.0: 2 ports detected
[    0.579357] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    0.579363] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned 
bus number 7
[    0.579370] uhci_hcd 0000:00:1d.1: detected 2 ports
[    0.579391] uhci_hcd 0000:00:1d.1: irq 19, io port 0x00009400
[    0.579445] usb usb7: New USB device found, idVendor=1d6b, 
idProduct=0001, bcdDevice= 6.10
[    0.579448] usb usb7: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    0.579450] usb usb7: Product: UHCI Host Controller
[    0.579452] usb usb7: Manufacturer: Linux 6.10.0 uhci_hcd
[    0.579453] usb usb7: SerialNumber: 0000:00:1d.1
[    0.579708] hub 7-0:1.0: USB hub found
[    0.579719] hub 7-0:1.0: 2 ports detected
[    0.579970] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    0.579976] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned 
bus number 8
[    0.579982] uhci_hcd 0000:00:1d.2: detected 2 ports
[    0.580000] uhci_hcd 0000:00:1d.2: irq 18, io port 0x00009480
[    0.580054] usb usb8: New USB device found, idVendor=1d6b, 
idProduct=0001, bcdDevice= 6.10
[    0.580057] usb usb8: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    0.580059] usb usb8: Product: UHCI Host Controller
[    0.580061] usb usb8: Manufacturer: Linux 6.10.0 uhci_hcd
[    0.580062] usb usb8: SerialNumber: 0000:00:1d.2
[    0.580318] hub 8-0:1.0: USB hub found
[    0.580330] hub 8-0:1.0: 2 ports detected
[    0.580525] i8042: PNP: No PS/2 controller found.
[    0.580527] i8042: Probing ports directly.
[    0.583347] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.583356] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.583524] mousedev: PS/2 mouse device common for all mice
[    0.583943] rtc_cmos 00:01: RTC can wake from S4
[    0.584238] rtc_cmos 00:01: registered as rtc0
[    0.584268] rtc_cmos 00:01: setting system clock to 
2024-09-16T15:52:10 UTC (1726501930)
[    0.584304] rtc_cmos 00:01: alarms up to one month, y3k, 114 bytes 
nvram, hpet irqs
[    0.584324] i2c_dev: i2c /dev entries driver
[    0.584740] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is 
disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[    0.584771] device-mapper: uevent: version 1.0.3
[    0.584924] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) 
initialised: dm-devel@lists.linux.dev
[    0.584955] platform eisa.0: Probing EISA bus 0
[    0.584958] platform eisa.0: EISA: Cannot allocate resource for mainboard
[    0.584960] platform eisa.0: Cannot allocate resource for EISA slot 1
[    0.584961] platform eisa.0: Cannot allocate resource for EISA slot 2
[    0.584963] platform eisa.0: Cannot allocate resource for EISA slot 3
[    0.584965] platform eisa.0: Cannot allocate resource for EISA slot 4
[    0.584966] platform eisa.0: Cannot allocate resource for EISA slot 5
[    0.584968] platform eisa.0: Cannot allocate resource for EISA slot 6
[    0.584969] platform eisa.0: Cannot allocate resource for EISA slot 7
[    0.584971] platform eisa.0: Cannot allocate resource for EISA slot 8
[    0.584972] platform eisa.0: EISA: Detected 0 cards
[    0.584975] intel_pstate: CPU model not supported
[    0.585611] ledtrig-cpu: registered to indicate activity on CPUs
[    0.585664] vesafb: mode is 1920x1080x32, linelength=7680, pages=0
[    0.585667] vesafb: scrolling: redraw
[    0.585668] vesafb: Truecolor: size=0:8:8:8, shift=0:16:8:0
[    0.585691] vesafb: framebuffer at 0xd0000000, mapped to 
0x(____ptrval____), using 8128k, total 8128k
[    0.585821] fbcon: Deferring console take-over
[    0.585823] fb0: VESA VGA frame buffer device
[    0.585856] fujitsu_tablet: Unknown (using defaults)
[    0.585976] drop_monitor: Initializing network drop monitor service
[    0.586297] NET: Registered PF_INET6 protocol family
[    0.812813] usb 1-5: new high-speed USB device number 2 using ehci-pci
[    0.969182] usb 1-5: New USB device found, idVendor=0409, 
idProduct=005a, bcdDevice= 1.00
[    0.969189] usb 1-5: New USB device strings: Mfr=0, Product=0, 
SerialNumber=0
[    0.969737] hub 1-5:1.0: USB hub found
[    0.969924] hub 1-5:1.0: 4 ports detected
[    1.036797] usb 6-1: new full-speed USB device number 2 using uhci_hcd
[    1.239812] usb 6-1: New USB device found, idVendor=1784, 
idProduct=0001, bcdDevice= 0.00
[    1.239821] usb 6-1: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[    1.239825] usb 6-1: Product: eHome Infrared Transceiver
[    1.239827] usb 6-1: Manufacturer: Topseed
[    1.239830] usb 6-1: SerialNumber: TS000IUz
[    1.264990] usb 1-5.1: new low-speed USB device number 3 using ehci-pci
[    1.379170] usb 1-5.1: New USB device found, idVendor=046d, 
idProduct=c317, bcdDevice= 0.70
[    1.379178] usb 1-5.1: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
[    1.379180] usb 1-5.1: Product: USB Multimedia Keyboard
[    1.379182] usb 1-5.1: Manufacturer: Logitech
[    1.456985] usb 1-5.2: new high-speed USB device number 4 using ehci-pci
[    1.528916] tsc: Refined TSC clocksource calibration: 2672.735 MHz
[    1.528932] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 
0x2686a22b34e, max_idle_ns: 440795332917 ns
[    1.529466] clocksource: Switched to clocksource tsc
[    1.566539] usb 1-5.2: New USB device found, idVendor=1532, 
idProduct=0e05, bcdDevice= 8.21
[    1.566547] usb 1-5.2: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
[    1.566550] usb 1-5.2: Product: Razer Kiyo Pro
[    1.566551] usb 1-5.2: Manufacturer: Razer Inc
[    1.644977] usb 1-5.4: new high-speed USB device number 5 using ehci-pci
[    1.765162] usb 1-5.4: New USB device found, idVendor=0bda, 
idProduct=2838, bcdDevice= 1.00
[    1.765170] usb 1-5.4: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[    1.765172] usb 1-5.4: Product: RTL2838UHIDIR
[    1.765174] usb 1-5.4: Manufacturer: Realtek
[    1.765175] usb 1-5.4: SerialNumber: 00000001
[    1.876987] usb 7-1: new low-speed USB device number 2 using uhci_hcd
[    2.071073] usb 7-1: New USB device found, idVendor=1c4f, 
idProduct=0034, bcdDevice= 1.10
[    2.071081] usb 7-1: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
[    2.071084] usb 7-1: Product: Usb Mouse
[    2.071085] usb 7-1: Manufacturer: SIGMACHIP
[    2.500978] usb 3-4: new high-speed USB device number 4 using ehci-pci
[    2.675119] usb 3-4: New USB device found, idVendor=0b05, 
idProduct=1784, bcdDevice= 1.01
[    2.675127] usb 3-4: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[    2.675129] usb 3-4: Product: 802.11 n WLAN
[    2.675131] usb 3-4: Manufacturer: Ralink
[    2.675133] usb 3-4: SerialNumber: 1.0
[    6.760936] Freeing initrd memory: 718512K
[    6.770228] Segment Routing with IPv6
[    6.770272] In-situ OAM (IOAM) with IPv6
[    6.770341] NET: Registered PF_PACKET protocol family
[    6.770604] Key type dns_resolver registered
[    6.771816] microcode: Current revision: 0x00000012
[    6.771821] microcode: Updated early from: 0x00000010
[    6.772418] IPI shorthand broadcast: enabled
[    6.774862] sched_clock: Marking stable (6772004461, 
829935)->(6839151451, -66317055)
[    6.775080] Timer migration: 2 hierarchy levels; 8 children per 
group; 2 crossnode level
[    6.775397] registered taskstats version 1
[    6.775810] Loading compiled-in X.509 certificates
[    6.776880] Loaded X.509 cert 'Build time autogenerated kernel key: 
82e5f8b468e02d124005a2717ca39eaa8cf6a0cf'
[    6.779631] Demotion targets for Node 0: null
[    6.779878] Key type .fscrypt registered
[    6.779880] Key type fscrypt-provisioning registered
[    6.791032] cryptd: max_cpu_qlen set to 1000
[    6.832848] Key type encrypted registered
[    6.832857] AppArmor: AppArmor sha256 policy hashing enabled
[    6.832869] ima: No TPM chip found, activating TPM-bypass!
[    6.832876] Loading compiled-in module X.509 certificates
[    6.833776] Loaded X.509 cert 'Build time autogenerated kernel key: 
82e5f8b468e02d124005a2717ca39eaa8cf6a0cf'
[    6.833779] ima: Allocated hash algorithm: sha1
[    6.833787] ima: No architecture policies found
[    6.833801] evm: Initialising EVM extended attributes:
[    6.833802] evm: security.selinux
[    6.833804] evm: security.SMACK64
[    6.833805] evm: security.SMACK64EXEC
[    6.833806] evm: security.SMACK64TRANSMUTE
[    6.833806] evm: security.SMACK64MMAP
[    6.833807] evm: security.apparmor
[    6.833808] evm: security.ima
[    6.833809] evm: security.capability
[    6.833810] evm: HMAC attrs: 0x1
[    6.834276] PM:   Magic number: 8:152:892
[    6.838659] RAS: Correctable Errors collector initialized.
[    6.838728] clk: Disabling unused clocks
[    6.838731] PM: genpd: Disabling unused power domains
[    6.840532] Freeing unused decrypted memory: 2036K
[    6.841731] Freeing unused kernel image (initmem) memory: 4840K
[    6.841925] Write protecting the kernel read-only data: 28672k
[    6.842744] Freeing unused kernel image (rodata/data gap) memory: 912K
[    6.934789] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    6.934917] x86/mm: Checking user space page tables
[    6.995740] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    6.995747] Run /init as init process
[    6.995748]   with arguments:
[    6.995749]     /init
[    6.995750]     splash
[    6.995751]   with environment:
[    6.995752]     HOME=/
[    6.995753]     TERM=linux
[    6.995754]     BOOT_IMAGE=/vmlinuz-6.10.0
[    7.155759] ACPI Warning: SystemIO range 
0x0000000000000828-0x000000000000082F conflicts with OpRegion 
0x0000000000000800-0x000000000000084F (\PMRG) (20240322/utaddress-204)
[    7.155772] ACPI: OSL: Resource conflict; ACPI support missing from 
driver?
[    7.155776] ACPI Warning: SystemIO range 
0x0000000000000530-0x000000000000053F conflicts with OpRegion 
0x0000000000000500-0x000000000000053F (\GPS0) (20240322/utaddress-204)
[    7.155783] ACPI: OSL: Resource conflict; ACPI support missing from 
driver?
[    7.155785] ACPI Warning: SystemIO range 
0x0000000000000500-0x000000000000052F conflicts with OpRegion 
0x0000000000000500-0x000000000000053F (\GPS0) (20240322/utaddress-204)
[    7.155791] ACPI: OSL: Resource conflict; ACPI support missing from 
driver?
[    7.155793] lpc_ich: Resource conflict(s) found affecting gpio_ich
[    7.160960] sky2: driver version 1.30
[    7.161131] sky2 0000:08:00.0: Yukon-2 EC Ultra chip revision 3
[    7.161493] sky2 0000:08:00.0 eth0: addr 00:23:54:9e:5b:d0
[    7.161603] sky2 0000:06:00.0: Yukon-2 EC Ultra chip revision 3
[    7.162950] sky2 0000:06:00.0 eth1: addr 00:23:54:9e:5b:cf
[    7.164768] ahci 0000:00:1f.2: version 3.0
[    7.165123] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
[    7.165167] ahci 0000:00:1f.2: AHCI vers 0001.0200, 32 command slots, 
3 Gbps, SATA mode
[    7.165172] ahci 0000:00:1f.2: 6/6 ports implemented (port mask 0x3f)
[    7.165175] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo 
pmp pio slum part ccc ems sxs
[    7.170483] ACPI Warning: SystemIO range 
0x0000000000000400-0x000000000000041F conflicts with OpRegion 
0x0000000000000400-0x000000000000040F (\SMRG) (20240322/utaddress-204)
[    7.170494] ACPI: OSL: Resource conflict; ACPI support missing from 
driver?
[    7.178634] hid: raw HID events driver (C) Jiri Kosina
[    7.210502] sky2 0000:08:00.0 enp8s0: renamed from eth0
[    7.210959] sky2 0000:06:00.0 enp6s0: renamed from eth1
[    7.224234] usbcore: registered new interface driver usbhid
[    7.224239] usbhid: USB HID core driver
[    7.228100] input: Logitech USB Multimedia Keyboard as 
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5.1/1-5.1:1.0/0003:046D:C317.0001/input/input5
[    7.229801] scsi host0: ahci
[    7.230294] scsi host1: ahci
[    7.230490] scsi host2: ahci
[    7.230764] scsi host3: ahci
[    7.231020] scsi host4: ahci
[    7.231419] scsi host5: ahci
[    7.231505] ata1: SATA max UDMA/133 abar m2048@0xfb5fc000 port 
0xfb5fc100 irq 29 lpm-pol 0
[    7.231509] ata2: SATA max UDMA/133 abar m2048@0xfb5fc000 port 
0xfb5fc180 irq 29 lpm-pol 0
[    7.231512] ata3: SATA max UDMA/133 abar m2048@0xfb5fc000 port 
0xfb5fc200 irq 29 lpm-pol 0
[    7.231515] ata4: SATA max UDMA/133 abar m2048@0xfb5fc000 port 
0xfb5fc280 irq 29 lpm-pol 0
[    7.231518] ata5: SATA max UDMA/133 abar m2048@0xfb5fc000 port 
0xfb5fc300 irq 29 lpm-pol 0
[    7.231520] ata6: SATA max UDMA/133 abar m2048@0xfb5fc000 port 
0xfb5fc380 irq 29 lpm-pol 0
[    7.276930] firewire_ohci 0000:0b:02.0: added OHCI v1.10 device as 
card 0, 4 IR + 8 IT contexts, quirks 0x11
[    7.285398] hid-generic 0003:046D:C317.0001: input,hidraw0: USB HID 
v1.10 Keyboard [Logitech USB Multimedia Keyboard] on 
usb-0000:00:1a.7-5.1/input0
[    7.285634] input: Logitech USB Multimedia Keyboard System Control as 
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5.1/1-5.1:1.1/0003:046D:C317.0002/input/input6
[    7.290268] ACPI: bus type drm_connector registered
[    7.348978] input: Logitech USB Multimedia Keyboard Consumer Control 
as 
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5.1/1-5.1:1.1/0003:046D:C317.0002/input/input7
[    7.349160] hid-generic 0003:046D:C317.0002: input,hidraw1: USB HID 
v1.10 Device [Logitech USB Multimedia Keyboard] on 
usb-0000:00:1a.7-5.1/input1
[    7.349346] input: SIGMACHIP Usb Mouse as 
/devices/pci0000:00/0000:00:1d.1/usb7/7-1/7-1:1.0/0003:1C4F:0034.0003/input/input8
[    7.349643] hid-generic 0003:1C4F:0034.0003: input,hidraw2: USB HID 
v1.10 Mouse [SIGMACHIP Usb Mouse] on usb-0000:00:1d.1-1/input0
[    7.704933] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    7.705709] ata1.00: ATA-10: WD Blue SA510 2.5 2TB, 530309WD, max 
UDMA/133
[    7.705751] ata1.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 
32), AA
[    7.706301] ata1.00: Features: Dev-Sleep
[    7.707046] ata1.00: configured for UDMA/133
[    7.707312] scsi 0:0:0:0: Direct-Access     ATA      WD Blue SA510 2. 
09WD PQ: 0 ANSI: 5
[    7.707624] scsi 0:0:0:0: Attached scsi generic sg0 type 0
[    7.801093] firewire_core 0000:0b:02.0: created device fw0: GUID 
001e8c0001b0584a, S400
[    8.184929] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    8.196283] ata2.00: ATA-8: Corsair Force 3 SSD, 1.3.2, max UDMA/133
[    8.196800] ata2.00: 234441648 sectors, multi 16: LBA48 NCQ (depth 
32), AA
[    8.206697] ata2.00: configured for UDMA/133
[    8.206879] scsi 1:0:0:0: Direct-Access     ATA      Corsair Force 3  
2    PQ: 0 ANSI: 5
[    8.207357] scsi 1:0:0:0: Attached scsi generic sg1 type 0
[    8.680925] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    8.681736] ata3.00: ATA-10: WD Blue SA510 2.5 2TB, 530309WD, max 
UDMA/133
[    8.681879] ata3.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 
32), AA
[    8.682621] ata3.00: Features: Dev-Sleep
[    8.683693] ata3.00: configured for UDMA/133
[    8.683903] scsi 2:0:0:0: Direct-Access     ATA      WD Blue SA510 2. 
09WD PQ: 0 ANSI: 5
[    8.684619] scsi 2:0:0:0: Attached scsi generic sg2 type 0
[    9.160920] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    9.162096] ata4.00: ATA-8: ST3500418AS, CC38, max UDMA/133
[    9.162103] ata4.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 32)
[    9.163530] ata4.00: configured for UDMA/133
[    9.163710] scsi 3:0:0:0: Direct-Access     ATA ST3500418AS      CC38 
PQ: 0 ANSI: 5
[    9.164017] scsi 3:0:0:0: Attached scsi generic sg3 type 0
[    9.640926] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    9.641108] ata5.00: ATA-10: KINGSTON SA400S37480G, SBFKK1B3, max 
UDMA/133
[    9.641159] ata5.00: 937703088 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    9.641356] ata5.00: configured for UDMA/133
[    9.641757] scsi 4:0:0:0: Direct-Access     ATA      KINGSTON SA400S3 
K1B3 PQ: 0 ANSI: 5
[    9.642439] scsi 4:0:0:0: Attached scsi generic sg4 type 0
[   10.116921] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   10.118401] ata6.00: ATAPI: DRW-24F1ST   d, 2.00, max UDMA/133
[   10.119936] ata6.00: configured for UDMA/133
[   10.123437] scsi 5:0:0:0: CD-ROM            ASUS DRW-24F1ST   d   
2.00 PQ: 0 ANSI: 5
[   10.204527] sr 5:0:0:0: [sr0] scsi3-mmc drive: 48x/12x writer dvd-ram 
cd/rw xa/form2 cdda tray
[   10.204533] cdrom: Uniform CD-ROM driver Revision: 3.20
[   10.237972] sr 5:0:0:0: Attached scsi CD-ROM sr0
[   10.238178] sr 5:0:0:0: Attached scsi generic sg5 type 5
[   10.243323] scsi host6: pata_marvell
[   10.243496] scsi host7: pata_marvell
[   10.243550] ata7: PATA max UDMA/100 cmd 0xcc00 ctl 0xc880 bmdma 
0xc400 irq 16 lpm-pol 0
[   10.243553] ata8: PATA max UDMA/133 cmd 0xc800 ctl 0xc480 bmdma 
0xc408 irq 16 lpm-pol 0
[   10.618642] sd 1:0:0:0: [sdb] 234441648 512-byte logical blocks: (120 
GB/112 GiB)
[   10.618669] sd 1:0:0:0: [sdb] Write Protect is off
[   10.618674] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   10.618706] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   10.618725] sd 0:0:0:0: [sda] 3907029168 512-byte logical blocks: 
(2.00 TB/1.82 TiB)
[   10.618746] sd 0:0:0:0: [sda] Write Protect is off
[   10.618753] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   10.618768] sd 2:0:0:0: [sdd] 3907029168 512-byte logical blocks: 
(2.00 TB/1.82 TiB)
[   10.618769] sd 1:0:0:0: [sdb] Preferred minimum I/O size 512 bytes
[   10.618771] sd 4:0:0:0: [sde] 937703088 512-byte logical blocks: (480 
GB/447 GiB)
[   10.618774] sd 3:0:0:0: [sdc] 976773168 512-byte logical blocks: (500 
GB/466 GiB)
[   10.618782] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   10.618790] sd 2:0:0:0: [sdd] Write Protect is off
[   10.618795] sd 2:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[   10.618808] sd 3:0:0:0: [sdc] Write Protect is off
[   10.618809] sd 4:0:0:0: [sde] Write Protect is off
[   10.618813] sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[   10.618815] sd 4:0:0:0: [sde] Mode Sense: 00 3a 00 00
[   10.618832] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[   10.618833] sd 2:0:0:0: [sdd] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   10.618855] sd 4:0:0:0: [sde] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   10.618856] sd 3:0:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   10.618892] sd 2:0:0:0: [sdd] Preferred minimum I/O size 512 bytes
[   10.618904] sd 4:0:0:0: [sde] Preferred minimum I/O size 512 bytes
[   10.618947] sd 3:0:0:0: [sdc] Preferred minimum I/O size 512 bytes
[   10.620288]  sde: sde1
[   10.620419] sd 4:0:0:0: [sde] Attached SCSI disk
[   10.620613]  sda: sda1
[   10.620744] sd 0:0:0:0: [sda] Attached SCSI disk
[   10.620967] sd 2:0:0:0: [sdd] Attached SCSI disk
[   10.623291]  sdb: sdb1 sdb2 sdb3
[   10.623541] sd 1:0:0:0: [sdb] Attached SCSI disk
[   10.637746]  sdc: sdc1
[   10.637892] sd 3:0:0:0: [sdc] Attached SCSI disk
[   15.759932] [drm] amdgpu kernel modesetting enabled.
[   15.760169] amdgpu: Virtual CRAT table created for CPU
[   15.760203] amdgpu: Topology: Add CPU node
[   15.760502] [drm] initializing kernel modesetting (BEIGE_GOBY 
0x1002:0x743F 0x148C:0x2415 0xC1).
[   15.760519] [drm] register mmio base: 0xFB700000
[   15.760520] [drm] register mmio size: 1048576
[   15.764353] [drm] add ip block number 0 <nv_common>
[   15.764355] [drm] add ip block number 1 <gmc_v10_0>
[   15.764357] [drm] add ip block number 2 <navi10_ih>
[   15.764359] [drm] add ip block number 3 <psp>
[   15.764360] [drm] add ip block number 4 <smu>
[   15.764361] [drm] add ip block number 5 <dm>
[   15.764363] [drm] add ip block number 6 <gfx_v10_0>
[   15.764364] [drm] add ip block number 7 <sdma_v5_2>
[   15.764366] [drm] add ip block number 8 <vcn_v3_0>
[   15.764379] resource: resource sanity check: requesting [mem 
0x00000000000c0000-0x00000000000dffff], which spans more than PCI Bus 
0000:00 [mem 0x000d0000-0x000dffff window]
[   15.764383] caller pci_map_rom+0x83/0x220 mapping multiple BARs
[   15.764391] amdgpu 0000:04:00.0: No more image in the PCI ROM
[   15.764412] amdgpu 0000:04:00.0: amdgpu: Fetched VBIOS from ROM BAR
[   15.764414] amdgpu: ATOM BIOS: 113-001-XT7
[   15.777550] [drm] VCN(0) decode is enabled in VM mode
[   15.781178] amdgpu 0000:04:00.0: vgaarb: deactivate vga console
[   15.781185] amdgpu 0000:04:00.0: amdgpu: Trusted Memory Zone (TMZ) 
feature disabled as experimental (default)
[   15.781194] amdgpu 0000:04:00.0: amdgpu: PCIE atomic ops is not supported
[   15.781245] [drm] vm size is 262144 GB, 4 levels, block size is 
9-bit, fragment size is 9-bit
[   15.781261] amdgpu 0000:04:00.0: amdgpu: VRAM: 4080M 
0x0000008000000000 - 0x00000080FEFFFFFF (4080M used)
[   15.781264] amdgpu 0000:04:00.0: amdgpu: GART: 512M 
0x0000000000000000 - 0x000000001FFFFFFF
[   15.781277] [drm] Detected VRAM RAM=4080M, BAR=256M
[   15.781279] [drm] RAM width 64bits GDDR6
[   15.783108] [drm] amdgpu: 4080M of VRAM memory ready
[   15.783112] [drm] amdgpu: 5979M of GTT memory ready.
[   15.783133] [drm] GART: num cpu pages 131072, num gpu pages 131072
[   15.783255] [drm] PCIE GART of 512M enabled (table at 
0x0000008000800000).
[   18.564918] random: crng init done
[   19.594908] amdgpu 0000:04:00.0: amdgpu: STB initialized to 2048 entries
[   19.595220] [drm] Loading DMUB firmware via PSP: version=0x02020020
[   19.595937] [drm] use_doorbell being set to: [true]
[   19.595955] [drm] Found VCN firmware Version ENC: 1.31 DEC: 3 VEP: 0 
Revision: 2
[   19.595965] amdgpu 0000:04:00.0: amdgpu: Will use PSP to load VCN 
firmware
[   19.663643] amdgpu 0000:04:00.0: amdgpu: reserve 0xa00000 from 
0x80fd000000 for PSP TMR
[   19.765435] amdgpu 0000:04:00.0: amdgpu: RAS: optional ras ta ucode 
is not available
[   19.781512] amdgpu 0000:04:00.0: amdgpu: SECUREDISPLAY: securedisplay 
ta ucode is not available
[   19.781538] amdgpu 0000:04:00.0: amdgpu: smu driver if version = 
0x0000000d, smu fw if version = 0x00000010, smu fw program = 0, version 
= 0x00492400 (73.36.0)
[   19.781544] amdgpu 0000:04:00.0: amdgpu: SMU driver if version not 
matched
[   19.781581] amdgpu 0000:04:00.0: amdgpu: use vbios provided pptable
[   19.828182] amdgpu 0000:04:00.0: amdgpu: SMU is initialized successfully!
[   19.828795] [drm] Display Core v3.2.281 initialized on DCN 3.0.3
[   19.828798] [drm] DP-HDMI FRL PCON supported
[   19.829988] [drm] DMUB hardware initialized: version=0x02020020
[   19.914675] [drm] kiq ring mec 2 pipe 1 q 0
[   19.956011] amdgpu: HMM registered 4080MB device memory
[   19.963868] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[   19.963883] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[   19.964255] amdgpu: Virtual CRAT table created for GPU
[   19.964896] amdgpu: Topology: Add dGPU node [0x743f:0x1002]
[   19.964900] kfd kfd: amdgpu: added device 1002:743f
[   19.964919] amdgpu 0000:04:00.0: amdgpu: SE 1, SH per SE 2, CU per SH 
8, active_cu_number 16
[   19.964924] amdgpu 0000:04:00.0: amdgpu: ring gfx_0.0.0 uses VM inv 
eng 0 on hub 0
[   19.964926] amdgpu 0000:04:00.0: amdgpu: ring gfx_0.1.0 uses VM inv 
eng 1 on hub 0
[   19.964927] amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.0 uses VM inv 
eng 4 on hub 0
[   19.964929] amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.0 uses VM inv 
eng 5 on hub 0
[   19.964931] amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.0 uses VM inv 
eng 6 on hub 0
[   19.964933] amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.0 uses VM inv 
eng 7 on hub 0
[   19.964935] amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.1 uses VM inv 
eng 8 on hub 0
[   19.964936] amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.1 uses VM inv 
eng 9 on hub 0
[   19.964938] amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.1 uses VM inv 
eng 10 on hub 0
[   19.964940] amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.1 uses VM inv 
eng 11 on hub 0
[   19.964941] amdgpu 0000:04:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv 
eng 12 on hub 0
[   19.964943] amdgpu 0000:04:00.0: amdgpu: ring sdma0 uses VM inv eng 
13 on hub 0
[   19.964945] amdgpu 0000:04:00.0: amdgpu: ring vcn_dec_0 uses VM inv 
eng 0 on hub 8
[   19.966250] amdgpu 0000:04:00.0: amdgpu: Using BACO for runtime pm
[   19.966781] [drm] Initialized amdgpu 3.57.0 20150101 for 0000:04:00.0 
on minor 0
[   19.975362] fbcon: amdgpudrmfb (fb0) is primary device
[   19.975369] fbcon: Deferring console take-over
[   19.975373] amdgpu 0000:04:00.0: [drm] fb0: amdgpudrmfb frame buffer 
device
[   20.228955] raid6: sse2x4   gen()  9291 MB/s
[   20.296948] raid6: sse2x2   gen() 11878 MB/s
[   20.364954] raid6: sse2x1   gen()  9701 MB/s
[   20.364956] raid6: using algorithm sse2x2 gen() 11878 MB/s
[   20.432953] raid6: .... xor() 7209 MB/s, rmw enabled
[   20.432955] raid6: using ssse3x2 recovery algorithm
[   20.435790] xor: measuring software checksum speed
[   20.436528]    prefetch64-sse  : 13382 MB/sec
[   20.437363]    generic_sse     : 13081 MB/sec
[   20.437365] xor: using function: prefetch64-sse (13382 MB/sec)
[   20.440149] async_tx: api initialized (async)
[   20.583585] [drm] DSC precompute is not needed.
[   21.349186] Btrfs loaded, zoned=yes, fsverity=yes
[   21.603021] EXT4-fs (sde1): mounted filesystem 
94072726-5fed-439f-a496-8e6aaa88617e ro with ordered data mode. Quota 
mode: none.
[   22.130926] systemd[1]: Inserted module 'autofs4'
[   22.204145] systemd[1]: systemd 249.11-0ubuntu3.12 running in system 
mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT 
+GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC 
+KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY -P11KIT -QRENCODE 
+BZIP2 +LZ4 +XZ +ZLIB +ZSTD -XKBCOMMON +UTMP +SYSVINIT 
default-hierarchy=unified)
[   22.204288] systemd[1]: Detected architecture x86-64.
[   22.735897] systemd[1]: Configuration file 
/run/systemd/system/netplan-ovs-cleanup.service is marked 
world-inaccessible. This has no effect as configuration data is 
accessible via APIs without restrictions. Proceeding anyway.
[   22.799432] systemd[1]: Accepting user/group name '${GNUNET_USER}', 
which does not match strict user/group name rules.
[   22.858633] systemd[1]: Queued start job for default target Graphical 
Interface.
[   22.874653] systemd[1]: Created slice Slice /system/modprobe.
[   22.875236] systemd[1]: Created slice Slice /system/systemd-fsck.
[   22.875643] systemd[1]: Created slice User and Session Slice.
[   22.875739] systemd[1]: Started Forward Password Requests to Wall 
Directory Watch.
[   22.875956] systemd[1]: Set up automount Arbitrary Executable File 
Formats File System Automount Point.
[   22.876079] systemd[1]: Reached target User and Group Name Lookups.
[   22.876116] systemd[1]: Reached target Slice Units.
[   22.876156] systemd[1]: Reached target Local Verity Protected Volumes.
[   22.876274] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[   22.876418] systemd[1]: Listening on LVM2 poll daemon socket.
[   22.882624] systemd[1]: Listening on RPCbind Server Activation Socket.
[   22.882878] systemd[1]: Listening on Syslog Socket.
[   22.885196] systemd[1]: Listening on Process Core Dump Socket.
[   22.885361] systemd[1]: Listening on fsck to fsckd communication Socket.
[   22.885472] systemd[1]: Listening on initctl Compatibility Named Pipe.
[   22.885847] systemd[1]: Listening on Journal Audit Socket.
[   22.886025] systemd[1]: Listening on Journal Socket (/dev/log).
[   22.886243] systemd[1]: Listening on Journal Socket.
[   22.886851] systemd[1]: Listening on udev Control Socket.
[   22.887021] systemd[1]: Listening on udev Kernel Socket.
[   22.888546] systemd[1]: Mounting Huge Pages File System...
[   22.890099] systemd[1]: Mounting POSIX Message Queue File System...
[   22.891576] systemd[1]: Mounting Kernel Debug File System...
[   22.893148] systemd[1]: Mounting Kernel Trace File System...
[   22.895537] systemd[1]: Starting Journal Service...
[   22.895676] systemd[1]: Condition check resulted in Kernel Module 
supporting RPCSEC_GSS being skipped.
[   22.895813] systemd[1]: Finished Availability of block devices.
[   22.897611] systemd[1]: Starting Set the console keyboard layout...
[   22.898972] systemd[1]: Starting Create List of Static Device Nodes...
[   22.900321] systemd[1]: Starting Monitoring of LVM2 mirrors, 
snapshots etc. using dmeventd or progress polling...
[   22.901626] systemd[1]: Starting Load Kernel Module configfs...
[   22.903328] systemd[1]: Starting Load Kernel Module drm...
[   22.905106] systemd[1]: Starting Load Kernel Module efi_pstore...
[   22.906391] systemd[1]: Starting Load Kernel Module fuse...
[   22.906762] systemd[1]: Condition check resulted in File System Check 
on Root Device being skipped.
[   22.914574] systemd[1]: Starting Load Kernel Modules...
[   22.915825] systemd[1]: Starting Remount Root and Kernel File Systems...
[   22.917138] systemd[1]: Starting Coldplug All udev Devices...
[   22.919764] systemd[1]: Mounted Huge Pages File System.
[   22.919930] systemd[1]: Mounted POSIX Message Queue File System.
[   22.920087] systemd[1]: Mounted Kernel Debug File System.
[   22.920240] systemd[1]: Mounted Kernel Trace File System.
[   22.920756] systemd[1]: Finished Create List of Static Device Nodes.
[   22.921158] systemd[1]: modprobe@configfs.service: Deactivated 
successfully.
[   22.921470] systemd[1]: Finished Load Kernel Module configfs.
[   22.921818] systemd[1]: modprobe@drm.service: Deactivated successfully.
[   22.922119] systemd[1]: Finished Load Kernel Module drm.
[   22.922477] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[   22.922777] systemd[1]: Finished Load Kernel Module fuse.
[   22.924081] systemd[1]: Mounting FUSE Control File System...
[   22.925275] systemd[1]: Mounting Kernel Configuration File System...
[   22.926672] systemd[1]: Mounted FUSE Control File System.
[   22.927652] systemd[1]: Mounted Kernel Configuration File System.
[   22.945693] systemd[1]: modprobe@efi_pstore.service: Deactivated 
successfully.
[   22.946071] systemd[1]: Finished Load Kernel Module efi_pstore.
[   22.986032] lp: driver loaded but no devices found
[   22.994903] EXT4-fs (sde1): re-mounted 
94072726-5fed-439f-a496-8e6aaa88617e r/w. Quota mode: none.
[   22.996356] ppdev: user-space parallel port driver
[   22.997000] systemd[1]: Finished Remount Root and Kernel File Systems.
[   22.997732] systemd[1]: Finished Set the console keyboard layout.
[   23.022160] systemd[1]: Finished Monitoring of LVM2 mirrors, 
snapshots etc. using dmeventd or progress polling.
[   23.022744] systemd[1]: Finished Load Kernel Modules.
[   23.022991] systemd[1]: Condition check resulted in Platform 
Persistent Storage Archival being skipped.
[   23.024232] systemd[1]: Starting Load/Save Random Seed...
[   23.025470] systemd[1]: Starting Apply Kernel Variables...
[   23.026695] systemd[1]: Starting Create System Users...
[   23.043337] systemd[1]: Finished Load/Save Random Seed.
[   23.043533] systemd[1]: Condition check resulted in First Boot 
Complete being skipped.
[   23.048879] systemd[1]: Finished Create System Users.
[   23.050336] systemd[1]: Starting Create Static Device Nodes in /dev...
[   23.056551] systemd[1]: Started Journal Service.
[   23.064847] systemd-journald[413]: Received client request to flush 
runtime journal.
[   23.523154] i5500_temp 0000:00:14.3: Sensor seems to be disabled
[   23.523563] EDAC MC0: Giving out device to module i7core_edac.c 
controller i7 core #0: DEV 0000:ff:03.0 (INTERRUPT)
[   23.523630] EDAC PCI0: Giving out device to module i7core_edac 
controller EDAC PCI controller: DEV 0000:ff:03.0 (POLLED)
[   23.523679] EDAC i7core: Driver loaded, 1 memory controller(s) found.
[   23.883855] mc: Linux media interface: v0.10
[   24.002719] videodev: Linux video capture interface: v2.00
[   24.062429] snd_hda_intel 0000:04:00.1: Force to non-snoop mode
[   24.082290] kvm_intel: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL does not 
work properly. Using workaround
[   24.095986] snd_hda_intel 0000:04:00.1: bound 0000:04:00.0 (ops 
amdgpu_dm_audio_component_bind_ops [amdgpu])
[   24.101203] input: HDA ATI HDMI HDMI/DP,pcm=3 as 
/devices/pci0000:00/0000:00:03.0/0000:02:00.0/0000:03:00.0/0000:04:00.1/sound/card1/input9
[   24.101354] input: HDA ATI HDMI HDMI/DP,pcm=7 as 
/devices/pci0000:00/0000:00:03.0/0000:02:00.0/0000:03:00.0/0000:04:00.1/sound/card1/input10
[   24.256417] Adding 15625212k swap on /dev/sdb2.  Priority:-2 
extents:1 across:15625212k SS
[   24.267942] EXT4-fs (sdc1): mounted filesystem 
269c3cb0-82a8-484f-9f96-2569d52ced08 r/w with ordered data mode. Quota 
mode: none.
[   24.286119] EXT4-fs (sdd): mounted filesystem 
7f49ad40-e533-42c4-9977-7c4809d47b3d r/w with ordered data mode. Quota 
mode: none.
[   24.290470] EXT4-fs (sda1): mounted filesystem 
a7d8e4b2-e2df-4976-b661-37e48f7411cf r/w with ordered data mode. Quota 
mode: none.
[   24.291377] EXT4-fs (sdb3): mounted filesystem 
965f3d65-ec1b-49a8-a27a-a6989cecf661 r/w with ordered data mode. Quota 
mode: none.
[   24.300695] cx23885: cx23885 driver version 0.0.4 loaded
[   24.300902] cx23885: CORE cx23885[0]: subsystem: 0070:7801, board: 
Hauppauge WinTV-HVR1800 [card=2,autodetected]
[   24.474296] snd_hda_codec_analog hdaudioC0D0: autoconfig for AD1989B: 
line_outs=4 (0x12/0x16/0x24/0x25/0x0) type:line
[   24.474304] snd_hda_codec_analog hdaudioC0D0:    speaker_outs=0 
(0x0/0x0/0x0/0x0/0x0)
[   24.474307] snd_hda_codec_analog hdaudioC0D0:    hp_outs=1 
(0x11/0x0/0x0/0x0/0x0)
[   24.474309] snd_hda_codec_analog hdaudioC0D0:    mono: mono_out=0x0
[   24.474310] snd_hda_codec_analog hdaudioC0D0: dig-out=0x1b/0x1d
[   24.474312] snd_hda_codec_analog hdaudioC0D0:    inputs:
[   24.474314] snd_hda_codec_analog hdaudioC0D0:      Rear Mic=0x17
[   24.474316] snd_hda_codec_analog hdaudioC0D0:      Front Mic=0x14
[   24.474318] snd_hda_codec_analog hdaudioC0D0:      Line=0x15
[   24.474319] snd_hda_codec_analog hdaudioC0D0:      CD=0x18
[   24.504370] input: HDA Intel Rear Mic as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input11
[   24.504506] input: HDA Intel Front Mic as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input12
[   24.504613] input: HDA Intel Line as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input13
[   24.504744] input: HDA Intel Line Out Front as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input14
[   24.504843] input: HDA Intel Line Out Surround as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input15
[   24.504939] input: HDA Intel Line Out CLFE as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input16
[   24.505029] input: HDA Intel Line Out Side as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input17
[   24.505117] input: HDA Intel Front Headphone as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input18
[   24.671255] cfg80211: Loading compiled-in X.509 certificates for 
regulatory database
[   24.671737] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   24.672120] Loaded X.509 cert 'wens: 
61c038651aabdcf94bd0ac7ff06c7248db18c600'
[   24.732894] Registered IR keymap rc-rc6-mce
[   24.741669] tveeprom: Hauppauge model 78521, rev C1E9, serial# 4029759297
[   24.741675] tveeprom: MAC address is 00:0d:fe:31:3f:41
[   24.741677] tveeprom: tuner model is Philips 18271_8295 (idx 149, 
type 54)
[   24.741679] tveeprom: TV standards NTSC(M) ATSC/DVB Digital (eeprom 0x88)
[   24.741680] tveeprom: audio processor is CX23887 (idx 42)
[   24.741682] tveeprom: decoder processor is CX23887 (idx 37)
[   24.741683] tveeprom: has radio
[   24.741684] cx23885: cx23885[0]: hauppauge eeprom: model=78521
[   24.803261] IR RC6 protocol handler initialized
[   24.869002] rc rc0: Media Center Ed. eHome Infrared Remote 
Transceiver (1784:0001) as 
/devices/pci0000:00/0000:00:1d.0/usb6/6-1/6-1:1.0/rc/rc0
[   24.869100] rc rc0: lirc_dev: driver mceusb registered at minor = 0, 
raw IR receiver, raw IR transmitter
[   24.869163] input: Media Center Ed. eHome Infrared Remote Transceiver 
(1784:0001) as 
/devices/pci0000:00/0000:00:1d.0/usb6/6-1/6-1:1.0/rc/rc0/input19
[   24.877940] cx25840 7-0044: cx23887 A/V decoder found @ 0x88 (cx23885[0])
[   24.956620] usb 1-5.2: Found UVC 1.00 device Razer Kiyo Pro (1532:0e05)
[   24.960827] usbcore: registered new interface driver uvcvideo
[   24.984824] usb 1-5.2: current rate 16000 is different from the 
runtime rate 48000
[   25.069722] mceusb 6-1:1.0: long-range (0x1) receiver active
[   25.128958] mceusb 6-1:1.0: Registered Topseed eHome Infrared 
Transceiver with mce emulator interface version 1
[   25.128964] mceusb 6-1:1.0: 2 tx ports (0x3 cabled) and 2 rx sensors 
(0x1 active)
[   25.129005] usbcore: registered new interface driver mceusb
[   25.190898] usb 1-5.2: current rate 16000 is different from the 
runtime rate 24000
[   25.197190] usb 1-5.2: current rate 16000 is different from the 
runtime rate 32000
[   25.401560] usbcore: registered new interface driver snd-usb-audio
[   25.493062] usb 3-4: reset high-speed USB device number 4 using ehci-pci
[   25.582928] cx25840 7-0044: loaded v4l-cx23885-avcore-01.fw firmware 
(16382 bytes)
[   25.624159] tuner: 6-0042: Tuner -1 found with type(s) Radio TV.
[   25.664188] ieee80211 phy0: rt2x00_set_rt: Info - RT chipset 3071, 
rev 021c detected
[   25.669923] tda829x 6-0042: could not clearly identify tuner address, 
defaulting to 60
[   25.697225] tda18271 6-0060: creating new instance
[   25.699522] ieee80211 phy0: rt2x00_set_rf: Info - RF chipset 0008 
detected
[   25.699891] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
[   25.700739] usbcore: registered new interface driver rt2800usb
[   25.708316] rt2800usb 3-4:1.0 wlx20cf30a24130: renamed from wlan0
[   25.745266] tda18271: TDA18271HD/C1 detected @ 6-0060
[   26.261306] tda829x 6-0042: type set to tda8295+18271
[   27.635819] cx23885: cx23885[0]: registered device video2 [v4l2]
[   27.635939] cx23885: cx23885[0]: registered device vbi0
[   27.636241] cx23885: cx23885[0]: alsa: registered ALSA audio device
[   27.636494] cx23885: cx23885[0]: registered device video3 [mpeg]
[   27.636513] cx23885: Firmware and/or mailbox pointer not initialized 
or corrupted, signature = 0xbfbbb9fb, cmd = PING_FW
[   27.637471] cx23885 0000:09:00.0: Direct firmware load for 
v4l-cx23885-enc.fw failed with error -2
[   27.637480] cx23885: ERROR: Hotplug firmware request failed 
(v4l-cx23885-enc.fw).
[   27.637485] cx23885: Please fix your hotplug setup, the board will 
not work without firmware loaded!
[   27.637488] cx23885: cx23885_initialize_codec() f/w load failed
[   27.637492] cx23885: cx23885_dvb_register() allocating 1 frontend(s)
[   27.637496] cx23885: cx23885[0]: cx23885 based dvb card
[   27.692107] MT2131: successfully identified at address 0x61
[   27.693738] dvbdev: DVB: registering new adapter (cx23885[0])
[   27.693745] cx23885 0000:09:00.0: DVB: registering adapter 0 frontend 
0 (Samsung S5H1409 QAM/8VSB Frontend)...
[   27.694619] cx23885: cx23885_dev_checkrevision() Hardware revision = 0xb1
[   27.694628] cx23885: cx23885[0]/0: found at 0000:09:00.0, rev: 15, 
irq: 17, latency: 0, mmio: 0xfbc00000
[   27.839112] audit: type=1400 audit(1726501957.749:2): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="/usr/bin/lxc-start" pid=1456 comm="apparmor_parser"
[   27.840938] audit: type=1400 audit(1726501957.753:3): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="nvidia_modprobe" pid=1453 comm="apparmor_parser"
[   27.840947] audit: type=1400 audit(1726501957.753:4): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="nvidia_modprobe//kmod" pid=1453 comm="apparmor_parser"
[   27.841910] audit: type=1400 audit(1726501957.753:5): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="lsb_release" pid=1451 comm="apparmor_parser"
[   27.843776] audit: type=1400 audit(1726501957.753:6): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="/usr/bin/man" pid=1457 comm="apparmor_parser"
[   27.843786] audit: type=1400 audit(1726501957.753:7): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="man_filter" pid=1457 comm="apparmor_parser"
[   27.843791] audit: type=1400 audit(1726501957.753:8): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="man_groff" pid=1457 comm="apparmor_parser"
[   27.846241] audit: type=1400 audit(1726501957.757:9): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="libreoffice-oosplash" pid=1461 comm="apparmor_parser"
[   27.848766] audit: type=1400 audit(1726501957.757:10): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="tcpdump" pid=1460 comm="apparmor_parser"
[   27.848996] audit: type=1400 audit(1726501957.757:11): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="/usr/bin/redshift" pid=1459 comm="apparmor_parser"
[   28.078039] RPC: Registered named UNIX socket transport module.
[   28.078046] RPC: Registered udp transport module.
[   28.078048] RPC: Registered tcp transport module.
[   28.078050] RPC: Registered tcp-with-tls transport module.
[   28.078051] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   29.689253] sky2 0000:06:00.0 enp6s0: enabling interface
[   29.696486] sky2 0000:08:00.0 enp8s0: enabling interface
[   29.699433] ieee80211 phy0: rt2x00lib_request_firmware: Info - 
Loading firmware file 'rt2870.bin'
[   29.703492] ieee80211 phy0: rt2x00lib_request_firmware: Info - 
Firmware detected - version: 0.36
[   31.746005] wlx20cf30a24130: authenticate with fc:2b:b2:a7:af:02 
(local address=20:cf:30:a2:41:30)
[   31.746012] wlx20cf30a24130: send auth to fc:2b:b2:a7:af:02 (try 1/3)
[   31.759038] wlx20cf30a24130: authenticated
[   31.760995] wlx20cf30a24130: associate with fc:2b:b2:a7:af:02 (try 1/3)
[   31.774204] wlx20cf30a24130: RX AssocResp from fc:2b:b2:a7:af:02 
(capab=0x1411 status=0 aid=3)
[   31.793028] wlx20cf30a24130: associated
[   31.889030] wlx20cf30a24130: Limiting TX power to 30 (30 - 0) dBm as 
advertised by fc:2b:b2:a7:af:02
[   32.234519] usb 1-5.2: current rate 16000 is different from the 
runtime rate 48000
[   32.351430] usb 1-5.2: current rate 16000 is different from the 
runtime rate 48000
[   32.466328] usb 1-5.2: current rate 16000 is different from the 
runtime rate 48000
[   32.659103] sky2 0000:06:00.0 enp6s0: Link is up at 1000 Mbps, full 
duplex, flow control both
[   35.735367] kauditd_printk_skb: 25 callbacks suppressed
[   35.735373] audit: type=1400 audit(1726501965.645:37): 
apparmor="DENIED" operation="open" class="file" 
profile="/usr/sbin/cups-browsed" name="/usr/local/lib/libz.so.1.3" 
pid=2109 comm="cups-browsed" requested_mask="r" denied_mask="r" fsuid=0 
ouid=0
[   35.739762] audit: type=1400 audit(1726501965.649:38): 
apparmor="DENIED" operation="open" class="file" 
profile="/usr/sbin/cups-browsed" 
name="/usr/local/lib/libpng16.so.16.44.0" pid=2109 comm="cups-browsed" 
requested_mask="r" denied_mask="r" fsuid=0 ouid=0
[   37.931125] usb 1-5.2: current rate 16000 is different from the 
runtime rate 48000
[   38.044085] usb 1-5.2: current rate 16000 is different from the 
runtime rate 48000
[   38.162429] usb 1-5.2: current rate 16000 is different from the 
runtime rate 48000
[   41.771683] warning: `kdeconnectd' uses wireless extensions which 
will stop working for Wi-Fi 7 hardware; use nl80211

6.11.0.dmesg.txt

[    0.000000] Linux version 6.11.0 (root@freedom) (gcc (Ubuntu 
11.4.0-1ubuntu1~22.04) 11.4.0, GNU ld (GNU Binutils for Ubuntu) 2.38) #1 
SMP PREEMPT_DYNAMIC Sun Sep 15 13:10:55 MDT 2024
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.11.0 
root=UUID=94072726-5fed-439f-a496-8e6aaa88617e ro recovery nomodeset 
dis_ucode_ldr
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009e7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e800-0x000000000009ffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e4c00-0x00000000000fffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bf77ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bf780000-0x00000000bf797fff] 
ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000bf798000-0x00000000bf7dbfff] 
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bf7dc000-0x00000000bfffffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffe00000-0x00000000ffffffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000033fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] SMBIOS 2.5 present.
[    0.000000] DMI: System manufacturer System Product Name/P6T DELUXE, 
BIOS 2209    09/21/2010
[    0.000000] DMI: Memory slots populated: 6/6
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2672.592 MHz processor
[    0.001523] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.001528] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.001538] last_pfn = 0x340000 max_arch_pfn = 0x400000000
[    0.001547] total RAM covered: 12280M
[    0.001823] Found optimal setting for mtrr clean up
[    0.001825]  gran_size: 64K     chunk_size: 16M     num_reg: 6     
lose cover RAM: 0G
[    0.001832] MTRR map: 8 entries (5 fixed + 3 variable; max 21), built 
from 8 variable MTRRs
[    0.001835] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB WP  UC- WT
[    0.002966] e820: update [mem 0xbf800000-0xffffffff] usable ==> reserved
[    0.002978] last_pfn = 0xbf798 max_arch_pfn = 0x400000000
[    0.014939] found SMP MP-table at [mem 0x000ff780-0x000ff78f]
[    0.015459] RAMDISK: [mem 0x0b466000-0x37feefff]
[    0.015470] ACPI: Early table checksum verification disabled
[    0.015475] ACPI: RSDP 0x00000000000FB150 000024 (v02 ACPIAM)
[    0.015481] ACPI: XSDT 0x00000000BF780100 000064 (v01 092110 XSDT0924 
20100921 MSFT 00000097)
[    0.015490] ACPI: FACP 0x00000000BF780290 0000F4 (v03 092110 FACP0924 
20100921 MSFT 00000097)
[    0.015500] ACPI: DSDT 0x00000000BF7804B0 00B69B (v01 A1087 A1087001 
00000001 INTL 20060113)
[    0.015506] ACPI: FACS 0x00000000BF798000 000040
[    0.015512] ACPI: FACS 0x00000000BF798000 000040
[    0.015517] ACPI: APIC 0x00000000BF780390 0000D8 (v01 092110 APIC0924 
20100921 MSFT 00000097)
[    0.015524] ACPI: MCFG 0x00000000BF780470 00003C (v01 092110 OEMMCFG  
20100921 MSFT 00000097)
[    0.015530] ACPI: OEMB 0x00000000BF798040 000072 (v01 092110 OEMB0924 
20100921 MSFT 00000097)
[    0.015536] ACPI: HPET 0x00000000BF78F4B0 000038 (v01 092110 OEMHPET  
20100921 MSFT 00000097)
[    0.015543] ACPI: DMAR 0x00000000BF7980C0 000138 (v01 AMI OEMDMAR  
00000001 MSFT 00000097)
[    0.015549] ACPI: OSFR 0x00000000BF78F4F0 0000B0 (v01 092110 OEMOSFR  
20100921 MSFT 00000097)
[    0.015555] ACPI: SSDT 0x00000000BF799E10 000363 (v01 DpgPmm CpuPm    
00000012 INTL 20060113)
[    0.015560] ACPI: Reserving FACP table memory at [mem 
0xbf780290-0xbf780383]
[    0.015562] ACPI: Reserving DSDT table memory at [mem 
0xbf7804b0-0xbf78bb4a]
[    0.015564] ACPI: Reserving FACS table memory at [mem 
0xbf798000-0xbf79803f]
[    0.015566] ACPI: Reserving FACS table memory at [mem 
0xbf798000-0xbf79803f]
[    0.015568] ACPI: Reserving APIC table memory at [mem 
0xbf780390-0xbf780467]
[    0.015569] ACPI: Reserving MCFG table memory at [mem 
0xbf780470-0xbf7804ab]
[    0.015571] ACPI: Reserving OEMB table memory at [mem 
0xbf798040-0xbf7980b1]
[    0.015573] ACPI: Reserving HPET table memory at [mem 
0xbf78f4b0-0xbf78f4e7]
[    0.015575] ACPI: Reserving DMAR table memory at [mem 
0xbf7980c0-0xbf7981f7]
[    0.015577] ACPI: Reserving OSFR table memory at [mem 
0xbf78f4f0-0xbf78f59f]
[    0.015578] ACPI: Reserving SSDT table memory at [mem 
0xbf799e10-0xbf79a172]
[    0.015757] No NUMA configuration found
[    0.015759] Faking a node at [mem 0x0000000000000000-0x000000033fffffff]
[    0.015772] NODE_DATA(0) allocated [mem 0x33ffcd000-0x33fff7fff]
[    0.016171] Zone ranges:
[    0.016173]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.016176]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.016179]   Normal   [mem 0x0000000100000000-0x000000033fffffff]
[    0.016181]   Device   empty
[    0.016183] Movable zone start for each node
[    0.016186] Early memory node ranges
[    0.016187]   node   0: [mem 0x0000000000001000-0x000000000009dfff]
[    0.016190]   node   0: [mem 0x0000000000100000-0x00000000bf77ffff]
[    0.016193]   node   0: [mem 0x0000000100000000-0x000000033fffffff]
[    0.016198] Initmem setup node 0 [mem 
0x0000000000001000-0x000000033fffffff]
[    0.016205] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.016239] On node 0, zone DMA: 98 pages in unavailable ranges
[    0.043129] On node 0, zone Normal: 2176 pages in unavailable ranges
[    0.043426] ACPI: PM-Timer IO Port: 0x808
[    0.043455] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 
0-23
[    0.043463] IOAPIC[1]: apic_id 9, version 32, address 0xfec8a000, GSI 
24-47
[    0.043467] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.043471] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.043478] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.043481] ACPI: HPET id: 0x8086a301 base: 0xfed00000
[    0.043498] CPU topo: Max. logical packages:   2
[    0.043499] CPU topo: Max. logical dies:       2
[    0.043500] CPU topo: Max. dies per package:   1
[    0.043512] CPU topo: Max. threads per core:   2
[    0.043513] CPU topo: Num. cores per package:     4
[    0.043514] CPU topo: Num. threads per package:   8
[    0.043516] CPU topo: Allowing 8 present CPUs plus 8 hotplug CPUs
[    0.043533] PM: hibernation: Registered nosave memory: [mem 
0x00000000-0x00000fff]
[    0.043537] PM: hibernation: Registered nosave memory: [mem 
0x0009e000-0x0009efff]
[    0.043539] PM: hibernation: Registered nosave memory: [mem 
0x0009f000-0x0009ffff]
[    0.043540] PM: hibernation: Registered nosave memory: [mem 
0x000a0000-0x000e4fff]
[    0.043542] PM: hibernation: Registered nosave memory: [mem 
0x000e5000-0x000fffff]
[    0.043545] PM: hibernation: Registered nosave memory: [mem 
0xbf780000-0xbf797fff]
[    0.043546] PM: hibernation: Registered nosave memory: [mem 
0xbf798000-0xbf7dbfff]
[    0.043548] PM: hibernation: Registered nosave memory: [mem 
0xbf7dc000-0xbfffffff]
[    0.043549] PM: hibernation: Registered nosave memory: [mem 
0xc0000000-0xfedfffff]
[    0.043551] PM: hibernation: Registered nosave memory: [mem 
0xfee00000-0xfee00fff]
[    0.043552] PM: hibernation: Registered nosave memory: [mem 
0xfee01000-0xffdfffff]
[    0.043554] PM: hibernation: Registered nosave memory: [mem 
0xffe00000-0xffffffff]
[    0.043557] [mem 0xc0000000-0xfedfffff] available for PCI devices
[    0.043559] Booting paravirtualized kernel on bare hardware
[    0.043562] clocksource: refined-jiffies: mask: 0xffffffff 
max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.043573] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:16 
nr_cpu_ids:16 nr_node_ids:1
[    0.045258] percpu: Embedded 66 pages/cpu s233472 r8192 d28672 u524288
[    0.045272] pcpu-alloc: s233472 r8192 d28672 u524288 alloc=1*2097152
[    0.045277] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07
[    0.045288] pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15
[    0.045320] Kernel command line: BOOT_IMAGE=/vmlinuz-6.11.0 
root=UUID=94072726-5fed-439f-a496-8e6aaa88617e ro recovery nomodeset 
dis_ucode_ldr
[    0.045449] Booted with the nomodeset parameter. Only the system 
framebuffer will be available
[    0.045486] Unknown kernel command line parameters "recovery 
dis_ucode_ldr BOOT_IMAGE=/vmlinuz-6.11.0", will be passed to user space.
[    0.047629] Dentry cache hash table entries: 2097152 (order: 12, 
16777216 bytes, linear)
[    0.048739] Inode-cache hash table entries: 1048576 (order: 11, 
8388608 bytes, linear)
[    0.049136] Fallback order for Node 0: 0
[    0.049143] Built 1 zonelists, mobility grouping on.  Total pages: 
3143453
[    0.049145] Policy zone: Normal
[    0.049158] mem auto-init: stack:off, heap alloc:on, heap free:off
[    0.049173] software IO TLB: area num 16.
[    0.131104] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.131303] Kernel/User page tables isolation: enabled
[    0.131439] ftrace: allocating 53163 entries in 208 pages
[    0.142711] ftrace: allocated 208 pages with 3 groups
[    0.143750] Dynamic Preempt: voluntary
[    0.144117] rcu: Preemptible hierarchical RCU implementation.
[    0.144119] rcu:     RCU restricting CPUs from NR_CPUS=8192 to 
nr_cpu_ids=16.
[    0.144121]     Trampoline variant of Tasks RCU enabled.
[    0.144122]     Rude variant of Tasks RCU enabled.
[    0.144123]     Tracing variant of Tasks RCU enabled.
[    0.144125] rcu: RCU calculated value of scheduler-enlistment delay 
is 25 jiffies.
[    0.144126] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
[    0.144151] RCU Tasks: Setting shift to 4 and lim to 1 
rcu_task_cb_adjust=1.
[    0.144155] RCU Tasks Rude: Setting shift to 4 and lim to 1 
rcu_task_cb_adjust=1.
[    0.144159] RCU Tasks Trace: Setting shift to 4 and lim to 1 
rcu_task_cb_adjust=1.
[    0.150163] NR_IRQS: 524544, nr_irqs: 960, preallocated irqs: 16
[    0.150430] rcu: srcu_init: Setting srcu_struct sizes based on 
contention.
[    0.153580] Console: colour VGA+ 80x25
[    0.153584] printk: legacy console [tty0] enabled
[    0.162441] ACPI: Core revision 20240322
[    0.162811] clocksource: hpet: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 133484882848 ns
[    0.162909] APIC: Switch to symmetric I/O mode setup
[    0.162969] DMAR-IR: This system BIOS has enabled interrupt remapping
                on a chipset that contains an erratum making that
                feature unstable.  To maintain system stability
                interrupt remapping is being disabled.  Please
                contact your BIOS vendor for an update
[    0.163135] APIC: Switched APIC routing to: physical flat
[    0.163763] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.182910] clocksource: tsc-early: mask: 0xffffffffffffffff 
max_cycles: 0x26861b6054f, max_idle_ns: 440795311586 ns
[    0.183002] Calibrating delay loop (skipped), value calculated using 
timer frequency.. 5345.18 BogoMIPS (lpj=10690368)
[    0.183113] CPU0: Thermal monitoring enabled (TM1)
[    0.183206] Last level iTLB entries: 4KB 512, 2MB 7, 4MB 7
[    0.183269] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.183335] process: using mwait in idle threads
[    0.183395] Spectre V1 : Mitigation: usercopy/swapgs barriers and 
__user pointer sanitization
[    0.183478] Spectre V2 : Mitigation: Retpolines
[    0.183537] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling 
RSB on context switch
[    0.183616] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    0.183680] Speculative Store Bypass: Vulnerable
[    0.183739] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    0.183802] MMIO Stale Data: Unknown: No mitigations
[    0.183864] x86/fpu: x87 FPU will use FXSAVE
[    0.215044] Freeing SMP alternatives memory: 44K
[    0.215863] pid_max: default: 32768 minimum: 301
[    0.216946] LSM: initializing 
lsm=lockdown,capability,landlock,apparmor,ima,evm
[    0.217321] landlock: Up and running.
[    0.217418] AppArmor: AppArmor initialized
[    0.217889] Mount-cache hash table entries: 32768 (order: 6, 262144 
bytes, linear)
[    0.218000] Mountpoint-cache hash table entries: 32768 (order: 6, 
262144 bytes, linear)
[    0.315022] APIC calibration not consistent with PM-Timer: 125ms 
instead of 100ms
[    0.315110] APIC delta adjusted to PM-Timer: 835226 (1051097)
[    0.315179] smpboot: CPU0: Intel(R) Core(TM) i7 CPU 920  @ 2.67GHz 
(family: 0x6, model: 0x1a, stepping: 0x4)
[    0.315740] Performance Events: PEBS fmt1+, Nehalem events, 16-deep 
LBR, Intel PMU driver.
[    0.315844] core: CPU erratum AAJ80 worked around
[    0.315904] ... version:                3
[    0.315961] ... bit width:              48
[    0.316019] ... generic registers:      4
[    0.316076] ... value mask:             0000ffffffffffff
[    0.316137] ... max period:             000000007fffffff
[    0.316197] ... fixed-purpose events:   3
[    0.316254] ... event mask:             000000070000000f
[    0.316522] signal: max sigframe size: 1440
[    0.316603] Estimated ratio of average max frequency by base 
frequency (times 1024): 1075
[    0.316744] rcu: Hierarchical SRCU implementation.
[    0.316805] rcu:     Max phase no-delay instances is 1000.
[    0.316948] Timer migration: 2 hierarchy levels; 8 children per 
group; 2 crossnode level
[    0.318337] NMI watchdog: Enabled. Permanently consumes one hw-PMU 
counter.
[    0.318693] smp: Bringing up secondary CPUs ...
[    0.318970] smpboot: x86: Booting SMP configuration:
[    0.318997] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6 #7
[    0.329005] MDS CPU bug present and SMT on, data leak possible. See 
https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for 
more details.
[    0.335078] smp: Brought up 1 node, 8 CPUs
[    0.335078] smpboot: Total of 8 processors activated (42761.47 BogoMIPS)
[    0.339147] Memory: 11491168K/12573812K available (20480K kernel 
code, 4237K rwdata, 7328K rodata, 4860K init, 5060K bss, 1068464K 
reserved, 0K cma-reserved)
[    0.339917] devtmpfs: initialized
[    0.339917] x86/mm: Memory block size: 128MB
[    0.341070] ACPI: PM: Registering ACPI NVS region [mem 
0xbf798000-0xbf7dbfff] (278528 bytes)
[    0.341070] clocksource: jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.343031] futex hash table entries: 4096 (order: 6, 262144 bytes, 
linear)
[    0.343671] pinctrl core: initialized pinctrl subsystem
[    0.343845] PM: RTC time: 15:45:50, date: 2024-09-16
[    0.344838] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.345292] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic 
allocations
[    0.345590] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for 
atomic allocations
[    0.345913] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for 
atomic allocations
[    0.346020] audit: initializing netlink subsys (disabled)
[    0.346098] audit: type=2000 audit(1726501549.180:1): 
state=initialized audit_enabled=0 res=1
[    0.346098] thermal_sys: Registered thermal governor 'fair_share'
[    0.346098] thermal_sys: Registered thermal governor 'bang_bang'
[    0.346098] thermal_sys: Registered thermal governor 'step_wise'
[    0.346098] thermal_sys: Registered thermal governor 'user_space'
[    0.346098] thermal_sys: Registered thermal governor 'power_allocator'
[    0.346098] EISA bus registered
[    0.346098] cpuidle: using governor ladder
[    0.346098] cpuidle: using governor menu
[    0.346098] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.347349] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) 
for domain 0000 [bus 00-ff]
[    0.347433] PCI: not using ECAM ([mem 0xe0000000-0xefffffff] not 
reserved)
[    0.347495] PCI: Using configuration type 1 for base access
[    0.347764] kprobes: kprobe jump-optimization is enabled. All kprobes 
are optimized if possible.
[    0.349869] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.351003] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.355104] ACPI: Added _OSI(Module Device)
[    0.355165] ACPI: Added _OSI(Processor Device)
[    0.355225] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.355285] ACPI: Added _OSI(Processor Aggregator Device)
[    0.369402] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.403713] ACPI: Dynamic OEM Table Load:
[    0.403789] ACPI: SSDT 0xFFFF98E480972000 001C0C (v01 DpgPmm P001Ist  
00000011 INTL 20060113)
[    0.408197] ACPI: Interpreter enabled
[    0.408275] ACPI: PM: (supports S0 S1 S3 S4 S5)
[    0.408332] ACPI: Using IOAPIC for interrupt routing
[    0.408437] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) 
for domain 0000 [bus 00-ff]
[    0.409915] PCI: ECAM [mem 0xe0000000-0xefffffff] reserved as ACPI 
motherboard resource
[    0.410009] PCI: Using host bridge windows from ACPI; if necessary, 
use "pci=nocrs" and report a bug
[    0.410089] PCI: Using E820 reservations for host bridge windows
[    0.410370] ACPI: Enabled 13 GPEs in block 00 to 3F
[    0.420949] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.421017] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM 
ClockPM Segments MSI EDR HPX-Type3]
[    0.421103] acpi PNP0A08:00: _OSC: OS requested [PCIeHotplug 
SHPCHotplug PME AER PCIeCapability LTR DPC]
[    0.421183] acpi PNP0A08:00: _OSC: platform willing to grant 
[PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR DPC]
[    0.421265] acpi PNP0A08:00: _OSC: platform retains control of PCIe 
features (AE_NOT_FOUND)
[    0.421836] PCI host bridge to bus 0000:00
[    0.421898] pci_bus 0000:00: root bus resource [io 0x0000-0x0cf7 window]
[    0.421960] pci_bus 0000:00: root bus resource [io 0x0d00-0xffff window]
[    0.422022] pci_bus 0000:00: root bus resource [mem 
0x000a0000-0x000bffff window]
[    0.422099] pci_bus 0000:00: root bus resource [mem 
0x000d0000-0x000dffff window]
[    0.422175] pci_bus 0000:00: root bus resource [mem 
0xc0000000-0xdfffffff window]
[    0.422251] pci_bus 0000:00: root bus resource [mem 
0xf0000000-0xfed8ffff window]
[    0.422328] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.422410] pci 0000:00:00.0: [8086:3405] type 00 class 0x060000 PCIe 
Root Port
[    0.422513] pci 0000:00:00.0: enabling Extended Tags
[    0.422614] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
[    0.422776] pci 0000:00:01.0: [8086:3408] type 01 class 0x060400 PCIe 
Root Port
[    0.422869] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.422943] pci 0000:00:01.0: enabling Extended Tags
[    0.423058] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.423257] pci 0000:00:03.0: [8086:340a] type 01 class 0x060400 PCIe 
Root Port
[    0.423354] pci 0000:00:03.0: PCI bridge to [bus 02-04]
[    0.423415] pci 0000:00:03.0:   bridge window [io 0xa000-0xafff]
[    0.423477] pci 0000:00:03.0:   bridge window [mem 0xfb600000-0xfb8fffff]
[    0.423545] pci 0000:00:03.0:   bridge window [mem 
0xcfe00000-0xdfffffff 64bit pref]
[    0.423627] pci 0000:00:03.0: enabling Extended Tags
[    0.423729] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    0.423917] pci 0000:00:07.0: [8086:340e] type 01 class 0x060400 PCIe 
Root Port
[    0.424009] pci 0000:00:07.0: PCI bridge to [bus 05]
[    0.424083] pci 0000:00:07.0: enabling Extended Tags
[    0.424185] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    0.424370] pci 0000:00:14.0: [8086:342e] type 00 class 0x080000 PCIe 
Root Complex Integrated Endpoint
[    0.424560] pci 0000:00:14.1: [8086:3422] type 00 class 0x080000 PCIe 
Root Complex Integrated Endpoint
[    0.424746] pci 0000:00:14.2: [8086:3423] type 00 class 0x080000 PCIe 
Root Complex Integrated Endpoint
[    0.424928] pci 0000:00:14.3: [8086:3438] type 00 class 0x080000 
conventional PCI endpoint
[    0.425098] pci 0000:00:1a.0: [8086:3a37] type 00 class 0x0c0300 
conventional PCI endpoint
[    0.425214] pci 0000:00:1a.0: BAR 4 [io  0x9800-0x981f]
[    0.425394] pci 0000:00:1a.1: [8086:3a38] type 00 class 0x0c0300 
conventional PCI endpoint
[    0.425511] pci 0000:00:1a.1: BAR 4 [io  0x9880-0x989f]
[    0.425702] pci 0000:00:1a.2: [8086:3a39] type 00 class 0x0c0300 
conventional PCI endpoint
[    0.425820] pci 0000:00:1a.2: BAR 4 [io  0x9c00-0x9c1f]
[    0.426012] pci 0000:00:1a.7: [8086:3a3c] type 00 class 0x0c0320 
conventional PCI endpoint
[    0.426105] pci 0000:00:1a.7: BAR 0 [mem 0xfb5ff000-0xfb5ff3ff]
[    0.426245] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.426403] pci 0000:00:1b.0: [8086:3a3e] type 00 class 0x040300 PCIe 
Root Complex Integrated Endpoint
[    0.426499] pci 0000:00:1b.0: BAR 0 [mem 0xfb5f8000-0xfb5fbfff 64bit]
[    0.426635] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.426784] pci 0000:00:1c.0: [8086:3a40] type 01 class 0x060400 PCIe 
Root Port
[    0.426884] pci 0000:00:1c.0: PCI bridge to [bus 0a]
[    0.426954] pci 0000:00:1c.0:   bridge window [mem 
0xfaf00000-0xfaffffff 64bit pref]
[    0.427053] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.427234] pci 0000:00:1c.1: [8086:3a42] type 01 class 0x060400 PCIe 
Root Port
[    0.427336] pci 0000:00:1c.1: PCI bridge to [bus 09]
[    0.427399] pci 0000:00:1c.1:   bridge window [mem 0xfbc00000-0xfbdfffff]
[    0.427520] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.427703] pci 0000:00:1c.2: [8086:3a44] type 01 class 0x060400 PCIe 
Root Port
[    0.427804] pci 0000:00:1c.2: PCI bridge to [bus 08]
[    0.427865] pci 0000:00:1c.2:   bridge window [io 0xd000-0xdfff]
[    0.427927] pci 0000:00:1c.2:   bridge window [mem 0xfbb00000-0xfbbfffff]
[    0.428789] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.428975] pci 0000:00:1c.4: [8086:3a48] type 01 class 0x060400 PCIe 
Root Port
[    0.429076] pci 0000:00:1c.4: PCI bridge to [bus 07]
[    0.429137] pci 0000:00:1c.4:   bridge window [io 0xc000-0xcfff]
[    0.429199] pci 0000:00:1c.4:   bridge window [mem 0xfba00000-0xfbafffff]
[    0.429320] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.429505] pci 0000:00:1c.5: [8086:3a4a] type 01 class 0x060400 PCIe 
Root Port
[    0.429607] pci 0000:00:1c.5: PCI bridge to [bus 06]
[    0.429669] pci 0000:00:1c.5:   bridge window [io 0xb000-0xbfff]
[    0.429731] pci 0000:00:1c.5:   bridge window [mem 0xfb900000-0xfb9fffff]
[    0.429854] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.430036] pci 0000:00:1d.0: [8086:3a34] type 00 class 0x0c0300 
conventional PCI endpoint
[    0.430154] pci 0000:00:1d.0: BAR 4 [io  0x9080-0x909f]
[    0.430337] pci 0000:00:1d.1: [8086:3a35] type 00 class 0x0c0300 
conventional PCI endpoint
[    0.430454] pci 0000:00:1d.1: BAR 4 [io  0x9400-0x941f]
[    0.430637] pci 0000:00:1d.2: [8086:3a36] type 00 class 0x0c0300 
conventional PCI endpoint
[    0.430754] pci 0000:00:1d.2: BAR 4 [io  0x9480-0x949f]
[    0.430942] pci 0000:00:1d.7: [8086:3a3a] type 00 class 0x0c0320 
conventional PCI endpoint
[    0.431016] pci 0000:00:1d.7: BAR 0 [mem 0xfb5fe000-0xfb5fe3ff]
[    0.431157] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.431314] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401 
conventional PCI bridge
[    0.431416] pci 0000:00:1e.0: PCI bridge to [bus 0b] (subtractive decode)
[    0.431481] pci 0000:00:1e.0:   bridge window [io 0xe000-0xefff]
[    0.431543] pci 0000:00:1e.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    0.431726] pci 0000:00:1f.0: [8086:3a16] type 00 class 0x060100 
conventional PCI endpoint
[    0.431880] pci 0000:00:1f.0: quirk: [io  0x0800-0x087f] claimed by 
ICH6 ACPI/GPIO/TCO
[    0.431961] pci 0000:00:1f.0: quirk: [io  0x0500-0x053f] claimed by 
ICH6 GPIO
[    0.432024] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 
0294 (mask 0003)
[    0.432103] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 3 PIO at 
4700 (mask 001f)
[    0.432329] pci 0000:00:1f.2: [8086:3a22] type 00 class 0x010601 
conventional PCI endpoint
[    0.432420] pci 0000:00:1f.2: BAR 0 [io  0x8c00-0x8c07]
[    0.432484] pci 0000:00:1f.2: BAR 1 [io  0x8880-0x8883]
[    0.432548] pci 0000:00:1f.2: BAR 2 [io  0x8800-0x8807]
[    0.432612] pci 0000:00:1f.2: BAR 3 [io  0x8480-0x8483]
[    0.432676] pci 0000:00:1f.2: BAR 4 [io  0x8400-0x841f]
[    0.432741] pci 0000:00:1f.2: BAR 5 [mem 0xfb5fc000-0xfb5fc7ff]
[    0.432840] pci 0000:00:1f.2: PME# supported from D3hot
[    0.432992] pci 0000:00:1f.3: [8086:3a30] type 00 class 0x0c0500 
conventional PCI endpoint
[    0.433086] pci 0000:00:1f.3: BAR 0 [mem 0xfb5fd000-0xfb5fd0ff 64bit]
[    0.433165] pci 0000:00:1f.3: BAR 4 [io  0x0400-0x041f]
[    0.433329] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.433446] pci 0000:02:00.0: [1002:1478] type 01 class 0x060400 PCIe 
Switch Upstream Port
[    0.433537] pci 0000:02:00.0: BAR 0 [mem 0xfb6fc000-0xfb6fffff]
[    0.433611] pci 0000:02:00.0: PCI bridge to [bus 03-04]
[    0.433675] pci 0000:02:00.0:   bridge window [io 0xa000-0xafff]
[    0.433737] pci 0000:02:00.0:   bridge window [mem 0xfb700000-0xfb8fffff]
[    0.433807] pci 0000:02:00.0:   bridge window [mem 
0xcfe00000-0xdfffffff 64bit pref]
[    0.433967] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.434092] pci 0000:02:00.0: 16.000 Gb/s available PCIe bandwidth, 
limited by 5.0 GT/s PCIe x4 link at 0000:00:03.0 (capable of 63.012 Gb/s 
with 16.0 GT/s PCIe x4 link)
[    0.443019] pci 0000:00:03.0: PCI bridge to [bus 02-04]
[    0.443145] pci 0000:03:00.0: [1002:1479] type 01 class 0x060400 PCIe 
Switch Downstream Port
[    0.443249] pci 0000:03:00.0: PCI bridge to [bus 04]
[    0.443312] pci 0000:03:00.0:   bridge window [io 0xa000-0xafff]
[    0.443374] pci 0000:03:00.0:   bridge window [mem 0xfb700000-0xfb8fffff]
[    0.443444] pci 0000:03:00.0:   bridge window [mem 
0xcfe00000-0xdfffffff 64bit pref]
[    0.443604] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    0.443827] pci 0000:02:00.0: PCI bridge to [bus 03-04]
[    0.443953] pci 0000:04:00.0: [1002:743f] type 00 class 0x030000 PCIe 
Legacy Endpoint
[    0.444047] pci 0000:04:00.0: BAR 0 [mem 0xd0000000-0xdfffffff 64bit 
pref]
[    0.444118] pci 0000:04:00.0: BAR 2 [mem 0xcfe00000-0xcfffffff 64bit 
pref]
[    0.444186] pci 0000:04:00.0: BAR 4 [io  0xa000-0xa0ff]
[    0.444251] pci 0000:04:00.0: BAR 5 [mem 0xfb700000-0xfb7fffff]
[    0.444318] pci 0000:04:00.0: ROM [mem 0xfb8c0000-0xfb8dffff pref]
[    0.444413] pci 0000:04:00.0: Video device with shadowed ROM at [mem 
0x000c0000-0x000dffff]
[    0.444550] pci 0000:04:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.444682] pci 0000:04:00.0: 16.000 Gb/s available PCIe bandwidth, 
limited by 5.0 GT/s PCIe x4 link at 0000:00:03.0 (capable of 252.048 
Gb/s with 16.0 GT/s PCIe x16 link)
[    0.444884] pci 0000:04:00.1: [1002:ab28] type 00 class 0x040300 PCIe 
Legacy Endpoint
[    0.444975] pci 0000:04:00.1: BAR 0 [mem 0xfb8fc000-0xfb8fffff]
[    0.445131] pci 0000:04:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.445329] pci 0000:03:00.0: PCI bridge to [bus 04]
[    0.445447] pci 0000:00:07.0: PCI bridge to [bus 05]
[    0.445551] pci 0000:00:1c.0: PCI bridge to [bus 0a]
[    0.445682] pci 0000:09:00.0: [14f1:8880] type 00 class 0x040000 PCIe 
Endpoint
[    0.445790] pci 0000:09:00.0: BAR 0 [mem 0xfbc00000-0xfbdfffff 64bit]
[    0.446019] pci 0000:09:00.0: supports D1 D2
[    0.446076] pci 0000:09:00.0: PME# supported from D0 D1 D2 D3hot
[    0.446268] pci 0000:09:00.0: disabling ASPM on pre-1.1 PCIe device.  
You can enable it with 'pcie_aspm=force'
[    0.446361] pci 0000:00:1c.1: PCI bridge to [bus 09]
[    0.446487] pci 0000:08:00.0: [11ab:4364] type 00 class 0x020000 PCIe 
Legacy Endpoint
[    0.446589] pci 0000:08:00.0: BAR 0 [mem 0xfbbfc000-0xfbbfffff 64bit]
[    0.446660] pci 0000:08:00.0: BAR 2 [io  0xd800-0xd8ff]
[    0.446758] pci 0000:08:00.0: ROM [mem 0xfbbc0000-0xfbbdffff pref]
[    0.446888] pci 0000:08:00.0: supports D1 D2
[    0.446945] pci 0000:08:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.447098] pci 0000:00:1c.2: ASPM: current common clock 
configuration is inconsistent, reconfiguring
[    0.459025] pci 0000:00:1c.2: PCI bridge to [bus 08]
[    0.459164] pci 0000:07:00.0: [11ab:6121] type 00 class 0x01018f PCIe 
Legacy Endpoint
[    0.459261] pci 0000:07:00.0: BAR 0 [io  0xcc00-0xcc07]
[    0.459329] pci 0000:07:00.0: BAR 1 [io  0xc880-0xc883]
[    0.459397] pci 0000:07:00.0: BAR 2 [io  0xc800-0xc807]
[    0.459466] pci 0000:07:00.0: BAR 3 [io  0xc480-0xc483]
[    0.459534] pci 0000:07:00.0: BAR 4 [io  0xc400-0xc40f]
[    0.459602] pci 0000:07:00.0: BAR 5 [mem 0xfbaffc00-0xfbafffff]
[    0.459735] pci 0000:07:00.0: supports D1
[    0.459791] pci 0000:07:00.0: PME# supported from D0 D1 D3hot
[    0.459938] pci 0000:07:00.0: disabling ASPM on pre-1.1 PCIe device.  
You can enable it with 'pcie_aspm=force'
[    0.460029] pci 0000:00:1c.4: PCI bridge to [bus 07]
[    0.460158] pci 0000:06:00.0: [11ab:4364] type 00 class 0x020000 PCIe 
Legacy Endpoint
[    0.460260] pci 0000:06:00.0: BAR 0 [mem 0xfb9fc000-0xfb9fffff 64bit]
[    0.460331] pci 0000:06:00.0: BAR 2 [io  0xb800-0xb8ff]
[    0.460428] pci 0000:06:00.0: ROM [mem 0xfb9c0000-0xfb9dffff pref]
[    0.460558] pci 0000:06:00.0: supports D1 D2
[    0.460615] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.460776] pci 0000:00:1c.5: ASPM: current common clock 
configuration is inconsistent, reconfiguring
[    0.471025] pci 0000:00:1c.5: PCI bridge to [bus 06]
[    0.471116] pci_bus 0000:0b: extended config space not accessible
[    0.471203] pci 0000:0b:02.0: [1106:3044] type 00 class 0x0c0010 
conventional PCI endpoint
[    0.471297] pci 0000:0b:02.0: BAR 0 [mem 0xfbeff000-0xfbeff7ff]
[    0.471365] pci 0000:0b:02.0: BAR 1 [io  0xec00-0xec7f]
[    0.471492] pci 0000:0b:02.0: supports D2
[    0.471549] pci 0000:0b:02.0: PME# supported from D2 D3hot D3cold
[    0.471691] pci 0000:00:1e.0: PCI bridge to [bus 0b] (subtractive decode)
[    0.471761] pci 0000:00:1e.0:   bridge window [io 0x0000-0x0cf7 
window] (subtractive decode)
[    0.471840] pci 0000:00:1e.0:   bridge window [io 0x0d00-0xffff 
window] (subtractive decode)
[    0.471918] pci 0000:00:1e.0:   bridge window [mem 
0x000a0000-0x000bffff window] (subtractive decode)
[    0.471998] pci 0000:00:1e.0:   bridge window [mem 
0x000d0000-0x000dffff window] (subtractive decode)
[    0.472077] pci 0000:00:1e.0:   bridge window [mem 
0xc0000000-0xdfffffff window] (subtractive decode)
[    0.472156] pci 0000:00:1e.0:   bridge window [mem 
0xf0000000-0xfed8ffff window] (subtractive decode)
[    0.473121] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
[    0.473250] ACPI: PCI: Interrupt link LNKB configured for IRQ 5
[    0.473378] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    0.473506] ACPI: PCI: Interrupt link LNKD configured for IRQ 14
[    0.473633] ACPI: PCI: Interrupt link LNKE configured for IRQ 15
[    0.473764] ACPI: PCI: Interrupt link LNKF configured for IRQ 3
[    0.473892] ACPI: PCI: Interrupt link LNKG configured for IRQ 7
[    0.474019] ACPI: PCI: Interrupt link LNKH configured for IRQ 4
[    0.474248] iommu: Default domain type: Translated
[    0.474248] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.474248] SCSI subsystem initialized
[    0.474248] libata version 3.00 loaded.
[    0.474248] ACPI: bus type USB registered
[    0.474248] usbcore: registered new interface driver usbfs
[    0.474248] usbcore: registered new interface driver hub
[    0.475003] usbcore: registered new device driver usb
[    0.475089] pps_core: LinuxPPS API ver. 1 registered
[    0.475148] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 
Rodolfo Giometti <giometti@linux.it>
[    0.475229] PTP clock support registered
[    0.475309] EDAC MC: Ver: 3.0.0
[    0.475309] NetLabel: Initializing
[    0.475325] NetLabel:  domain hash size = 128
[    0.475381] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.476190] NetLabel:  unlabeled traffic allowed by default
[    0.476269] PCI: Using ACPI for IRQ routing
[    0.482656] PCI: Discovered peer bus ff
[    0.482713] PCI: root bus ff: using default resources
[    0.482715] PCI: Probing PCI hardware (bus ff)
[    0.482741] PCI host bridge to bus 0000:ff
[    0.482799] pci_bus 0000:ff: root bus resource [io 0x0000-0xffff]
[    0.482860] pci_bus 0000:ff: root bus resource [mem 
0x00000000-0xfffffffff]
[    0.482922] pci_bus 0000:ff: No busn resource found for root bus, 
will use [bus ff-ff]
[    0.483000] pci_bus 0000:ff: busn_res: can not insert [bus ff] under 
domain [bus 00-ff] (conflicts with (null) [bus 00-ff])
[    0.483094] pci 0000:ff:00.0: [8086:2c41] type 00 class 0x060000 
conventional PCI endpoint
[    0.483226] pci 0000:ff:00.1: [8086:2c01] type 00 class 0x060000 
conventional PCI endpoint
[    0.483354] pci 0000:ff:02.0: [8086:2c10] type 00 class 0x060000 
conventional PCI endpoint
[    0.483478] pci 0000:ff:02.1: [8086:2c11] type 00 class 0x060000 
conventional PCI endpoint
[    0.483603] pci 0000:ff:03.0: [8086:2c18] type 00 class 0x060000 
conventional PCI endpoint
[    0.483729] pci 0000:ff:03.1: [8086:2c19] type 00 class 0x060000 
conventional PCI endpoint
[    0.483859] pci 0000:ff:03.4: [8086:2c1c] type 00 class 0x060000 
conventional PCI endpoint
[    0.483984] pci 0000:ff:04.0: [8086:2c20] type 00 class 0x060000 
conventional PCI endpoint
[    0.484110] pci 0000:ff:04.1: [8086:2c21] type 00 class 0x060000 
conventional PCI endpoint
[    0.484233] pci 0000:ff:04.2: [8086:2c22] type 00 class 0x060000 
conventional PCI endpoint
[    0.484357] pci 0000:ff:04.3: [8086:2c23] type 00 class 0x060000 
conventional PCI endpoint
[    0.484484] pci 0000:ff:05.0: [8086:2c28] type 00 class 0x060000 
conventional PCI endpoint
[    0.484607] pci 0000:ff:05.1: [8086:2c29] type 00 class 0x060000 
conventional PCI endpoint
[    0.484731] pci 0000:ff:05.2: [8086:2c2a] type 00 class 0x060000 
conventional PCI endpoint
[    0.484859] pci 0000:ff:05.3: [8086:2c2b] type 00 class 0x060000 
conventional PCI endpoint
[    0.484986] pci 0000:ff:06.0: [8086:2c30] type 00 class 0x060000 
conventional PCI endpoint
[    0.485110] pci 0000:ff:06.1: [8086:2c31] type 00 class 0x060000 
conventional PCI endpoint
[    0.485234] pci 0000:ff:06.2: [8086:2c32] type 00 class 0x060000 
conventional PCI endpoint
[    0.485359] pci 0000:ff:06.3: [8086:2c33] type 00 class 0x060000 
conventional PCI endpoint
[    0.485492] pci_bus 0000:ff: busn_res: [bus ff] end is updated to ff
[    0.485554] pci_bus 0000:ff: busn_res: can not insert [bus ff] under 
domain [bus 00-ff] (conflicts with (null) [bus 00-ff])
[    0.485645] PCI: pci_cache_line_size set to 64 bytes
[    0.485737] e820: reserve RAM buffer [mem 0x0009e800-0x0009ffff]
[    0.485740] e820: reserve RAM buffer [mem 0xbf780000-0xbfffffff]
[    0.485763] pci 0000:04:00.0: vgaarb: setting as boot VGA device
[    0.485763] pci 0000:04:00.0: vgaarb: bridge control possible
[    0.485763] pci 0000:04:00.0: vgaarb: VGA device added: 
decodes=io+mem,owns=io+mem,locks=none
[    0.485763] vgaarb: loaded
[    0.485763] hpet: 4 channels of 0 reserved for per-cpu timers
[    0.485763] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    0.485763] hpet0: 4 comparators, 64-bit 14.318180 MHz counter
[    0.488045] clocksource: Switched to clocksource tsc-early
[    0.489118] VFS: Disk quotas dquot_6.6.0
[    0.489275] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 
bytes)
[    0.489629] AppArmor: AppArmor Filesystem Enabled
[    0.489707] pnp: PnP ACPI init
[    0.489841] system 00:00: [mem 0xfbf00000-0xfbffffff] has been reserved
[    0.489905] system 00:00: [mem 0xfc000000-0xfcffffff] has been reserved
[    0.489967] system 00:00: [mem 0xfd000000-0xfdffffff] has been reserved
[    0.490028] system 00:00: [mem 0xfe000000-0xfebfffff] has been reserved
[    0.490090] system 00:00: [mem 0xfec8a000-0xfec8afff] could not be 
reserved
[    0.490153] system 00:00: [mem 0xfed10000-0xfed10fff] has been reserved
[    0.490540] system 00:02: [io  0x0290-0x029f] has been reserved
[    0.490540] system 00:03: [io  0x04d0-0x04d1] has been reserved
[    0.490540] system 00:03: [io  0x0800-0x087f] has been reserved
[    0.490540] system 00:03: [io  0x0500-0x057f] could not be reserved
[    0.490540] system 00:03: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.490540] system 00:03: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.490540] system 00:03: [mem 0xfed40000-0xfed8ffff] has been reserved
[    0.490540] system 00:04: [mem 0xffc00000-0xffdfffff] has been reserved
[    0.490601] system 00:05: [mem 0xfec00000-0xfec00fff] could not be 
reserved
[    0.490666] system 00:05: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.490885] system 00:06: [mem 0xe0000000-0xefffffff] has been reserved
[    0.491155] pnp 00:07: disabling [mem 0x000c0000-0x000cffff] because 
it overlaps 0000:04:00.0 BAR 6 [mem 0x000c0000-0x000dffff]
[    0.491276] system 00:07: [mem 0x00000000-0x0009ffff] could not be 
reserved
[    0.491339] system 00:07: [mem 0x000e0000-0x000fffff] could not be 
reserved
[    0.491401] system 00:07: [mem 0x00100000-0xbfffffff] could not be 
reserved
[    0.491463] system 00:07: [mem 0xfed90000-0xffffffff] could not be 
reserved
[    0.491686] pnp: PnP ACPI: found 8 devices
[    0.498190] clocksource: acpi_pm: mask: 0xffffff max_cycles: 
0xffffff, max_idle_ns: 2085701024 ns
[    0.498540] NET: Registered PF_INET protocol family
[    0.498855] IP idents hash table entries: 262144 (order: 9, 2097152 
bytes, linear)
[    0.503049] tcp_listen_portaddr_hash hash table entries: 8192 (order: 
5, 131072 bytes, linear)
[    0.503176] Table-perturb hash table entries: 65536 (order: 6, 262144 
bytes, linear)
[    0.503372] TCP established hash table entries: 131072 (order: 8, 
1048576 bytes, linear)
[    0.503848] TCP bind hash table entries: 65536 (order: 9, 2097152 
bytes, linear)
[    0.504223] TCP: Hash tables configured (established 131072 bind 65536)
[    0.504490] MPTCP token hash table entries: 16384 (order: 6, 393216 
bytes, linear)
[    0.504658] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.504790] UDP-Lite hash table entries: 8192 (order: 6, 262144 
bytes, linear)
[    0.504996] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.505063] NET: Registered PF_XDP protocol family
[    0.505136] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to 
[bus 0a] add_size 1000
[    0.505216] pci 0000:00:1c.0: bridge window [mem 
0x00100000-0x000fffff] to [bus 0a] add_size 200000 add_align 100000
[    0.505299] pci 0000:00:1c.1: bridge window [io  0x1000-0x0fff] to 
[bus 09] add_size 1000
[    0.505377] pci 0000:00:1c.1: bridge window [mem 
0x00100000-0x000fffff 64bit pref] to [bus 09] add_size 200000 add_align 
100000
[    0.505462] pci 0000:00:1c.2: bridge window [mem 
0x00100000-0x000fffff 64bit pref] to [bus 08] add_size 200000 add_align 
100000
[    0.505547] pci 0000:00:1c.4: bridge window [mem 
0x00100000-0x000fffff 64bit pref] to [bus 07] add_size 200000 add_align 
100000
[    0.505657] pci 0000:00:1c.5: bridge window [mem 
0x00100000-0x000fffff 64bit pref] to [bus 06] add_size 200000 add_align 
100000
[    0.505770] pci 0000:00:1c.0: bridge window [mem 
0xc0000000-0xc01fffff]: assigned
[    0.505850] pci 0000:00:1c.1: bridge window [mem 
0xc0200000-0xc03fffff 64bit pref]: assigned
[    0.505929] pci 0000:00:1c.2: bridge window [mem 
0xc0400000-0xc05fffff 64bit pref]: assigned
[    0.506008] pci 0000:00:1c.4: bridge window [mem 
0xc0600000-0xc07fffff 64bit pref]: assigned
[    0.506087] pci 0000:00:1c.5: bridge window [mem 
0xc0800000-0xc09fffff 64bit pref]: assigned
[    0.506167] pci 0000:00:1c.0: bridge window [io 0x1000-0x1fff]: assigned
[    0.506229] pci 0000:00:1c.1: bridge window [io 0x2000-0x2fff]: assigned
[    0.506292] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.506358] pci 0000:03:00.0: PCI bridge to [bus 04]
[    0.506417] pci 0000:03:00.0:   bridge window [io 0xa000-0xafff]
[    0.506480] pci 0000:03:00.0:   bridge window [mem 0xfb700000-0xfb8fffff]
[    0.506544] pci 0000:03:00.0:   bridge window [mem 
0xcfe00000-0xdfffffff 64bit pref]
[    0.506624] pci 0000:02:00.0: PCI bridge to [bus 03-04]
[    0.506684] pci 0000:02:00.0:   bridge window [io 0xa000-0xafff]
[    0.506747] pci 0000:02:00.0:   bridge window [mem 0xfb700000-0xfb8fffff]
[    0.506810] pci 0000:02:00.0:   bridge window [mem 
0xcfe00000-0xdfffffff 64bit pref]
[    0.506891] pci 0000:00:03.0: PCI bridge to [bus 02-04]
[    0.506950] pci 0000:00:03.0:   bridge window [io 0xa000-0xafff]
[    0.507012] pci 0000:00:03.0:   bridge window [mem 0xfb600000-0xfb8fffff]
[    0.507075] pci 0000:00:03.0:   bridge window [mem 
0xcfe00000-0xdfffffff 64bit pref]
[    0.507155] pci 0000:00:07.0: PCI bridge to [bus 05]
[    0.507220] pci 0000:00:1c.0: PCI bridge to [bus 0a]
[    0.507278] pci 0000:00:1c.0:   bridge window [io 0x1000-0x1fff]
[    0.507341] pci 0000:00:1c.0:   bridge window [mem 0xc0000000-0xc01fffff]
[    0.507404] pci 0000:00:1c.0:   bridge window [mem 
0xfaf00000-0xfaffffff 64bit pref]
[    0.507484] pci 0000:00:1c.1: PCI bridge to [bus 09]
[    0.507543] pci 0000:00:1c.1:   bridge window [io 0x2000-0x2fff]
[    0.507606] pci 0000:00:1c.1:   bridge window [mem 0xfbc00000-0xfbdfffff]
[    0.507669] pci 0000:00:1c.1:   bridge window [mem 
0xc0200000-0xc03fffff 64bit pref]
[    0.507750] pci 0000:00:1c.2: PCI bridge to [bus 08]
[    0.507809] pci 0000:00:1c.2:   bridge window [io 0xd000-0xdfff]
[    0.507871] pci 0000:00:1c.2:   bridge window [mem 0xfbb00000-0xfbbfffff]
[    0.507934] pci 0000:00:1c.2:   bridge window [mem 
0xc0400000-0xc05fffff 64bit pref]
[    0.508015] pci 0000:00:1c.4: PCI bridge to [bus 07]
[    0.508074] pci 0000:00:1c.4:   bridge window [io 0xc000-0xcfff]
[    0.508136] pci 0000:00:1c.4:   bridge window [mem 0xfba00000-0xfbafffff]
[    0.508199] pci 0000:00:1c.4:   bridge window [mem 
0xc0600000-0xc07fffff 64bit pref]
[    0.508281] pci 0000:00:1c.5: PCI bridge to [bus 06]
[    0.508340] pci 0000:00:1c.5:   bridge window [io 0xb000-0xbfff]
[    0.508402] pci 0000:00:1c.5:   bridge window [mem 0xfb900000-0xfb9fffff]
[    0.508465] pci 0000:00:1c.5:   bridge window [mem 
0xc0800000-0xc09fffff 64bit pref]
[    0.508546] pci 0000:00:1e.0: PCI bridge to [bus 0b]
[    0.508605] pci 0000:00:1e.0:   bridge window [io 0xe000-0xefff]
[    0.508668] pci 0000:00:1e.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    0.509471] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.509532] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.509592] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff 
window]
[    0.509657] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff 
window]
[    0.509719] pci_bus 0000:00: resource 8 [mem 0xc0000000-0xdfffffff 
window]
[    0.509780] pci_bus 0000:00: resource 9 [mem 0xf0000000-0xfed8ffff 
window]
[    0.509842] pci_bus 0000:02: resource 0 [io  0xa000-0xafff]
[    0.509902] pci_bus 0000:02: resource 1 [mem 0xfb600000-0xfb8fffff]
[    0.509962] pci_bus 0000:02: resource 2 [mem 0xcfe00000-0xdfffffff 
64bit pref]
[    0.510038] pci_bus 0000:03: resource 0 [io  0xa000-0xafff]
[    0.510098] pci_bus 0000:03: resource 1 [mem 0xfb700000-0xfb8fffff]
[    0.510158] pci_bus 0000:03: resource 2 [mem 0xcfe00000-0xdfffffff 
64bit pref]
[    0.510234] pci_bus 0000:04: resource 0 [io  0xa000-0xafff]
[    0.510293] pci_bus 0000:04: resource 1 [mem 0xfb700000-0xfb8fffff]
[    0.510354] pci_bus 0000:04: resource 2 [mem 0xcfe00000-0xdfffffff 
64bit pref]
[    0.510431] pci_bus 0000:0a: resource 0 [io  0x1000-0x1fff]
[    0.510490] pci_bus 0000:0a: resource 1 [mem 0xc0000000-0xc01fffff]
[    0.510550] pci_bus 0000:0a: resource 2 [mem 0xfaf00000-0xfaffffff 
64bit pref]
[    0.510626] pci_bus 0000:09: resource 0 [io  0x2000-0x2fff]
[    0.510685] pci_bus 0000:09: resource 1 [mem 0xfbc00000-0xfbdfffff]
[    0.510746] pci_bus 0000:09: resource 2 [mem 0xc0200000-0xc03fffff 
64bit pref]
[    0.510822] pci_bus 0000:08: resource 0 [io  0xd000-0xdfff]
[    0.510881] pci_bus 0000:08: resource 1 [mem 0xfbb00000-0xfbbfffff]
[    0.510942] pci_bus 0000:08: resource 2 [mem 0xc0400000-0xc05fffff 
64bit pref]
[    0.511018] pci_bus 0000:07: resource 0 [io  0xc000-0xcfff]
[    0.511077] pci_bus 0000:07: resource 1 [mem 0xfba00000-0xfbafffff]
[    0.511137] pci_bus 0000:07: resource 2 [mem 0xc0600000-0xc07fffff 
64bit pref]
[    0.511213] pci_bus 0000:06: resource 0 [io  0xb000-0xbfff]
[    0.511273] pci_bus 0000:06: resource 1 [mem 0xfb900000-0xfb9fffff]
[    0.511333] pci_bus 0000:06: resource 2 [mem 0xc0800000-0xc09fffff 
64bit pref]
[    0.511409] pci_bus 0000:0b: resource 0 [io  0xe000-0xefff]
[    0.511468] pci_bus 0000:0b: resource 1 [mem 0xfbe00000-0xfbefffff]
[    0.511529] pci_bus 0000:0b: resource 4 [io  0x0000-0x0cf7 window]
[    0.511589] pci_bus 0000:0b: resource 5 [io  0x0d00-0xffff window]
[    0.511649] pci_bus 0000:0b: resource 6 [mem 0x000a0000-0x000bffff 
window]
[    0.511711] pci_bus 0000:0b: resource 7 [mem 0x000d0000-0x000dffff 
window]
[    0.511772] pci_bus 0000:0b: resource 8 [mem 0xc0000000-0xdfffffff 
window]
[    0.511834] pci_bus 0000:0b: resource 9 [mem 0xf0000000-0xfed8ffff 
window]
[    0.511972] pci_bus 0000:ff: resource 4 [io  0x0000-0xffff]
[    0.512032] pci_bus 0000:ff: resource 5 [mem 0x00000000-0xfffffffff]
[    0.513973] pci 0000:04:00.1: D0 power state depends on 0000:04:00.0
[    0.514089] PCI: CLS 256 bytes, default 64
[    0.514216] DMAR: Host address width 39
[    0.514276] DMAR: DRHD base: 0x000000fbfff000 flags: 0x0
[    0.514295] Trying to unpack rootfs image as initramfs...
[    0.514351] DMAR: dmar0: reg_base_addr fbfff000 ver 1:0 cap 
c9008010e60262 ecap f0207a
[    0.514481] DMAR: DRHD base: 0x000000fbffe000 flags: 0x1
[    0.514556] DMAR: dmar1: reg_base_addr fbffe000 ver 1:0 cap 
c90780106f0462 ecap f020fe
[    0.514642] DMAR: RMRR base: 0x000000000ec000 end: 0x000000000effff
[    0.514709] DMAR: RMRR base: 0x000000bf7dc000 end: 0x000000bf7dbfff
[    0.514774] DMAR: [Firmware Bug]: Your BIOS is broken; bad RMRR 
[0x00000000bf7dc000-0x00000000bf7dbfff]
                BIOS vendor: American Megatrends Inc.; Ver: 2209 ; 
Product Version: System Version
[    0.514912] DMAR: ATSR flags: 0x0
[    0.515009] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.515075] software IO TLB: mapped [mem 
0x00000000bb780000-0x00000000bf780000] (64MB)
[    0.521401] Initialise system trusted keyrings
[    0.521483] Key type blacklist registered
[    0.521611] workingset: timestamp_bits=36 max_order=22 bucket_order=0
[    0.521698] zbud: loaded
[    0.524842] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.525236] fuse: init (API version 7.40)
[    0.525761] integrity: Platform Keyring initialized
[    0.554855] Key type asymmetric registered
[    0.554920] Asymmetric key parser 'x509' registered
[    0.555092] Block layer SCSI generic (bsg) driver version 0.4 loaded 
(major 243)
[    0.555240] io scheduler mq-deadline registered
[    0.555893] pcieport 0000:00:1c.0: enabling device (0106 -> 0107)
[    0.556166] pcieport 0000:00:1c.1: enabling device (0106 -> 0107)
[    0.557137] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.557258] Driver vt8623fb not loading because of nomodeset parameter
[    0.558067] input: Power Button as 
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.558179] ACPI: button: Power Button [PWRB]
[    0.558275] input: Power Button as 
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.558636] ACPI: button: Power Button [PWRF]
[    0.560651] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.565044] Linux agpgart interface v0.103
[    0.568906] loop: module loaded
[    0.569332] tun: Universal TUN/TAP device driver, 1.6
[    0.569449] PPP generic driver version 2.4.2
[    0.569932] VFIO - User Level meta-driver version: 0.3
[    0.570435] ehci-pci 0000:00:1a.7: EHCI Host Controller
[    0.570503] ehci-pci 0000:00:1a.7: new USB bus registered, assigned 
bus number 1
[    0.570591] ehci-pci 0000:00:1a.7: debug port 1
[    0.574585] ehci-pci 0000:00:1a.7: irq 18, io mem 0xfb5ff000
[    0.589569] ehci-pci 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    0.589728] usb usb1: New USB device found, idVendor=1d6b, 
idProduct=0002, bcdDevice= 6.11
[    0.589808] usb usb1: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    0.589885] usb usb1: Product: EHCI Host Controller
[    0.589943] usb usb1: Manufacturer: Linux 6.11.0 ehci_hcd
[    0.590001] usb usb1: SerialNumber: 0000:00:1a.7
[    0.590392] hub 1-0:1.0: USB hub found
[    0.590460] hub 1-0:1.0: 6 ports detected
[    0.590801] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    0.590869] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned 
bus number 2
[    0.590953] uhci_hcd 0000:00:1a.0: detected 2 ports
[    0.591047] uhci_hcd 0000:00:1a.0: irq 16, io port 0x00009800
[    0.591186] usb usb2: New USB device found, idVendor=1d6b, 
idProduct=0001, bcdDevice= 6.11
[    0.591266] usb usb2: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    0.591343] usb usb2: Product: UHCI Host Controller
[    0.591401] usb usb2: Manufacturer: Linux 6.11.0 uhci_hcd
[    0.591460] usb usb2: SerialNumber: 0000:00:1a.0
[    0.591634] hub 2-0:1.0: USB hub found
[    0.591698] hub 2-0:1.0: 2 ports detected
[    0.591942] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    0.592010] ehci-pci 0000:00:1d.7: new USB bus registered, assigned 
bus number 3
[    0.592097] ehci-pci 0000:00:1d.7: debug port 1
[    0.596068] ehci-pci 0000:00:1d.7: irq 23, io mem 0xfb5fe000
[    0.609563] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    0.609690] usb usb3: New USB device found, idVendor=1d6b, 
idProduct=0002, bcdDevice= 6.11
[    0.609773] usb usb3: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    0.609849] usb usb3: Product: EHCI Host Controller
[    0.609907] usb usb3: Manufacturer: Linux 6.11.0 ehci_hcd
[    0.609966] usb usb3: SerialNumber: 0000:00:1d.7
[    0.610301] hub 3-0:1.0: USB hub found
[    0.610369] hub 3-0:1.0: 6 ports detected
[    0.610698] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    0.610767] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned 
bus number 4
[    0.610850] uhci_hcd 0000:00:1a.1: detected 2 ports
[    0.610939] uhci_hcd 0000:00:1a.1: irq 21, io port 0x00009880
[    0.611057] usb usb4: New USB device found, idVendor=1d6b, 
idProduct=0001, bcdDevice= 6.11
[    0.611136] usb usb4: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    0.611212] usb usb4: Product: UHCI Host Controller
[    0.611270] usb usb4: Manufacturer: Linux 6.11.0 uhci_hcd
[    0.611329] usb usb4: SerialNumber: 0000:00:1a.1
[    0.611509] hub 4-0:1.0: USB hub found
[    0.611573] hub 4-0:1.0: 2 ports detected
[    0.611935] uhci_hcd 0000:00:1a.2: UHCI Host Controller
[    0.611999] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned 
bus number 5
[    0.612079] uhci_hcd 0000:00:1a.2: detected 2 ports
[    0.612163] uhci_hcd 0000:00:1a.2: irq 19, io port 0x00009c00
[    0.612275] usb usb5: New USB device found, idVendor=1d6b, 
idProduct=0001, bcdDevice= 6.11
[    0.612355] usb usb5: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    0.612431] usb usb5: Product: UHCI Host Controller
[    0.612489] usb usb5: Manufacturer: Linux 6.11.0 uhci_hcd
[    0.612548] usb usb5: SerialNumber: 0000:00:1a.2
[    0.612725] hub 5-0:1.0: USB hub found
[    0.612790] hub 5-0:1.0: 2 ports detected
[    0.613081] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    0.613146] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned 
bus number 6
[    0.613227] uhci_hcd 0000:00:1d.0: detected 2 ports
[    0.613301] uhci_hcd 0000:00:1d.0: irq 23, io port 0x00009080
[    0.613426] usb usb6: New USB device found, idVendor=1d6b, 
idProduct=0001, bcdDevice= 6.11
[    0.613507] usb usb6: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    0.613584] usb usb6: Product: UHCI Host Controller
[    0.613642] usb usb6: Manufacturer: Linux 6.11.0 uhci_hcd
[    0.613700] usb usb6: SerialNumber: 0000:00:1d.0
[    0.614618] hub 6-0:1.0: USB hub found
[    0.614689] hub 6-0:1.0: 2 ports detected
[    0.614982] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    0.615047] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned 
bus number 7
[    0.615128] uhci_hcd 0000:00:1d.1: detected 2 ports
[    0.615202] uhci_hcd 0000:00:1d.1: irq 19, io port 0x00009400
[    0.615313] usb usb7: New USB device found, idVendor=1d6b, 
idProduct=0001, bcdDevice= 6.11
[    0.615393] usb usb7: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    0.615469] usb usb7: Product: UHCI Host Controller
[    0.615527] usb usb7: Manufacturer: Linux 6.11.0 uhci_hcd
[    0.615586] usb usb7: SerialNumber: 0000:00:1d.1
[    0.615762] hub 7-0:1.0: USB hub found
[    0.615827] hub 7-0:1.0: 2 ports detected
[    0.616116] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    0.616180] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned 
bus number 8
[    0.616261] uhci_hcd 0000:00:1d.2: detected 2 ports
[    0.616335] uhci_hcd 0000:00:1d.2: irq 18, io port 0x00009480
[    0.616451] usb usb8: New USB device found, idVendor=1d6b, 
idProduct=0001, bcdDevice= 6.11
[    0.616531] usb usb8: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    0.616607] usb usb8: Product: UHCI Host Controller
[    0.616665] usb usb8: Manufacturer: Linux 6.11.0 uhci_hcd
[    0.616724] usb usb8: SerialNumber: 0000:00:1d.2
[    0.616900] hub 8-0:1.0: USB hub found
[    0.616965] hub 8-0:1.0: 2 ports detected
[    0.617241] i8042: PNP: No PS/2 controller found.
[    0.617301] i8042: Probing ports directly.
[    0.619926] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.619991] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.620231] mousedev: PS/2 mouse device common for all mice
[    0.620502] rtc_cmos 00:01: RTC can wake from S4
[    0.620823] rtc_cmos 00:01: registered as rtc0
[    0.620911] rtc_cmos 00:01: setting system clock to 
2024-09-16T15:45:50 UTC (1726501550)
[    0.621025] rtc_cmos 00:01: alarms up to one month, y3k, 114 bytes 
nvram, hpet irqs
[    0.621126] i2c_dev: i2c /dev entries driver
[    0.621603] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is 
disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[    0.621731] device-mapper: uevent: version 1.0.3
[    0.621877] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) 
initialised: dm-devel@lists.linux.dev
[    0.621987] platform eisa.0: Probing EISA bus 0
[    0.622046] platform eisa.0: EISA: Cannot allocate resource for mainboard
[    0.622108] platform eisa.0: Cannot allocate resource for EISA slot 1
[    0.622169] platform eisa.0: Cannot allocate resource for EISA slot 2
[    0.622230] platform eisa.0: Cannot allocate resource for EISA slot 3
[    0.622290] platform eisa.0: Cannot allocate resource for EISA slot 4
[    0.622351] platform eisa.0: Cannot allocate resource for EISA slot 5
[    0.622412] platform eisa.0: Cannot allocate resource for EISA slot 6
[    0.622473] platform eisa.0: Cannot allocate resource for EISA slot 7
[    0.622533] platform eisa.0: Cannot allocate resource for EISA slot 8
[    0.622594] platform eisa.0: EISA: Detected 0 cards
[    0.622653] intel_pstate: CPU model not supported
[    0.622931] ledtrig-cpu: registered to indicate activity on CPUs
[    0.623055] fujitsu_tablet: Unknown (using defaults)
[    0.623240] drop_monitor: Initializing network drop monitor service
[    0.623638] NET: Registered PF_INET6 protocol family
[    0.845564] usb 1-5: new high-speed USB device number 2 using ehci-pci
[    1.002340] usb 1-5: New USB device found, idVendor=0409, 
idProduct=005a, bcdDevice= 1.00
[    1.002428] usb 1-5: New USB device strings: Mfr=0, Product=0, 
SerialNumber=0
[    1.003003] hub 1-5:1.0: USB hub found
[    1.003318] hub 1-5:1.0: 4 ports detected
[    1.276633] usb 6-1: new full-speed USB device number 2 using uhci_hcd
[    1.288626] usb 1-5.1: new low-speed USB device number 3 using ehci-pci
[    1.403298] usb 1-5.1: New USB device found, idVendor=046d, 
idProduct=c317, bcdDevice= 0.70
[    1.403386] usb 1-5.1: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
[    1.403464] usb 1-5.1: Product: USB Multimedia Keyboard
[    1.403523] usb 1-5.1: Manufacturer: Logitech
[    1.466680] usb 6-1: New USB device found, idVendor=1784, 
idProduct=0001, bcdDevice= 0.00
[    1.466769] usb 6-1: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[    1.466832] usb 6-1: Product: eHome Infrared Transceiver
[    1.466892] usb 6-1: Manufacturer: Topseed
[    1.466949] usb 6-1: SerialNumber: TS000IUz
[    1.500632] usb 1-5.2: new high-speed USB device number 4 using ehci-pci
[    1.536623] tsc: Refined TSC clocksource calibration: 2672.733 MHz
[    1.536700] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 
0x2686a05b615, max_idle_ns: 440795253305 ns
[    1.537196] clocksource: Switched to clocksource tsc
[    1.610398] usb 1-5.2: New USB device found, idVendor=1532, 
idProduct=0e05, bcdDevice= 8.21
[    1.610488] usb 1-5.2: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
[    1.610566] usb 1-5.2: Product: Razer Kiyo Pro
[    1.610623] usb 1-5.2: Manufacturer: Razer Inc
[    1.688637] usb 1-5.4: new high-speed USB device number 5 using ehci-pci
[    1.808808] usb 1-5.4: New USB device found, idVendor=0bda, 
idProduct=2838, bcdDevice= 1.00
[    1.808897] usb 1-5.4: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[    1.808975] usb 1-5.4: Product: RTL2838UHIDIR
[    1.809033] usb 1-5.4: Manufacturer: Realtek
[    1.809091] usb 1-5.4: SerialNumber: 00000001
[    1.904609] usb 7-1: new low-speed USB device number 2 using uhci_hcd
[    2.102672] usb 7-1: New USB device found, idVendor=1c4f, 
idProduct=0034, bcdDevice= 1.10
[    2.102759] usb 7-1: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
[    2.102823] usb 7-1: Product: Usb Mouse
[    2.102880] usb 7-1: Manufacturer: SIGMACHIP
[    2.524624] usb 3-4: new high-speed USB device number 4 using ehci-pci
[    2.698975] usb 3-4: New USB device found, idVendor=0b05, 
idProduct=1784, bcdDevice= 1.01
[    2.699063] usb 3-4: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[    2.699127] usb 3-4: Product: 802.11 n WLAN
[    2.699184] usb 3-4: Manufacturer: Ralink
[    2.699241] usb 3-4: SerialNumber: 1.0
[    6.976898] Freeing initrd memory: 732708K
[    6.986507] Segment Routing with IPv6
[    6.986593] In-situ OAM (IOAM) with IPv6
[    6.986699] NET: Registered PF_PACKET protocol family
[    6.986876] Key type dns_resolver registered
[    6.987951] IPI shorthand broadcast: enabled
[    6.990314] sched_clock: Marking stable (6976004229, 
12538719)->(7057676614, -69133666)
[    6.990636] registered taskstats version 1
[    6.991328] Loading compiled-in X.509 certificates
[    6.992386] Loaded X.509 cert 'Build time autogenerated kernel key: 
8b9c4d5ea71199831d97e735201ace9ff8457a95'
[    6.995461] Demotion targets for Node 0: null
[    6.995709] Key type .fscrypt registered
[    6.995767] Key type fscrypt-provisioning registered
[    7.007124] cryptd: max_cpu_qlen set to 1000
[    7.047412] Key type encrypted registered
[    7.047478] AppArmor: AppArmor sha256 policy hashing enabled
[    7.047548] ima: No TPM chip found, activating TPM-bypass!
[    7.047619] Loading compiled-in module X.509 certificates
[    7.048586] Loaded X.509 cert 'Build time autogenerated kernel key: 
8b9c4d5ea71199831d97e735201ace9ff8457a95'
[    7.048676] ima: Allocated hash algorithm: sha1
[    7.048741] ima: No architecture policies found
[    7.048812] evm: Initialising EVM extended attributes:
[    7.048870] evm: security.selinux
[    7.048925] evm: security.SMACK64
[    7.048980] evm: security.SMACK64EXEC
[    7.049035] evm: security.SMACK64TRANSMUTE
[    7.049091] evm: security.SMACK64MMAP
[    7.049146] evm: security.apparmor
[    7.049201] evm: security.ima
[    7.049255] evm: security.capability
[    7.049310] evm: HMAC attrs: 0x1
[    7.049757] PM:   Magic number: 8:49:791
[    7.054239] RAS: Correctable Errors collector initialized.
[    7.054382] clk: Disabling unused clocks
[    7.054445] PM: genpd: Disabling unused power domains
[    7.059625] Freeing unused decrypted memory: 2036K
[    7.060894] Freeing unused kernel image (initmem) memory: 4860K
[    7.061160] Write protecting the kernel read-only data: 28672k
[    7.062031] Freeing unused kernel image (rodata/data gap) memory: 864K
[    7.151250] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    7.151442] x86/mm: Checking user space page tables
[    7.212156] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    7.212222] Run /init as init process
[    7.212278]   with arguments:
[    7.212279]     /init
[    7.212280]     recovery
[    7.212281]     dis_ucode_ldr
[    7.212282]   with environment:
[    7.212283]     HOME=/
[    7.212284]     TERM=linux
[    7.212285]     BOOT_IMAGE=/vmlinuz-6.11.0
[    7.364432] ACPI Warning: SystemIO range 
0x0000000000000828-0x000000000000082F conflicts with OpRegion 
0x0000000000000800-0x000000000000084F (\PMRG) (20240322/utaddress-204)
[    7.364565] ACPI: OSL: Resource conflict; ACPI support missing from 
driver?
[    7.364635] ACPI Warning: SystemIO range 
0x0000000000000530-0x000000000000053F conflicts with OpRegion 
0x0000000000000500-0x000000000000053F (\GPS0) (20240322/utaddress-204)
[    7.364752] ACPI: OSL: Resource conflict; ACPI support missing from 
driver?
[    7.364821] ACPI Warning: SystemIO range 
0x0000000000000500-0x000000000000052F conflicts with OpRegion 
0x0000000000000500-0x000000000000053F (\GPS0) (20240322/utaddress-204)
[    7.364937] ACPI: OSL: Resource conflict; ACPI support missing from 
driver?
[    7.365004] lpc_ich: Resource conflict(s) found affecting gpio_ich
[    7.370829] sky2: driver version 1.30
[    7.371054] sky2 0000:08:00.0: Yukon-2 EC Ultra chip revision 3
[    7.371479] sky2 0000:08:00.0 eth0: addr 00:23:54:9e:5b:d0
[    7.371637] sky2 0000:06:00.0: Yukon-2 EC Ultra chip revision 3
[    7.372728] sky2 0000:06:00.0 eth1: addr 00:23:54:9e:5b:cf
[    7.374655] ahci 0000:00:1f.2: version 3.0
[    7.374985] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
[    7.375094] ahci 0000:00:1f.2: AHCI vers 0001.0200, 32 command slots, 
3 Gbps, SATA mode
[    7.375177] ahci 0000:00:1f.2: 6/6 ports implemented (port mask 0x3f)
[    7.375242] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo 
pmp pio slum part ccc ems sxs
[    7.385005] ACPI Warning: SystemIO range 
0x0000000000000400-0x000000000000041F conflicts with OpRegion 
0x0000000000000400-0x000000000000040F (\SMRG) (20240322/utaddress-204)
[    7.385128] ACPI: OSL: Resource conflict; ACPI support missing from 
driver?
[    7.389528] hid: raw HID events driver (C) Jiri Kosina
[    7.425364] sky2 0000:06:00.0 enp6s0: renamed from eth1
[    7.425700] sky2 0000:08:00.0 enp8s0: renamed from eth0
[    7.433464] scsi host0: ahci
[    7.433862] scsi host1: ahci
[    7.434116] scsi host2: ahci
[    7.434448] scsi host3: ahci
[    7.434746] scsi host4: ahci
[    7.435032] scsi host5: ahci
[    7.435181] ata1: SATA max UDMA/133 abar m2048@0xfb5fc000 port 
0xfb5fc100 irq 29 lpm-pol 0
[    7.435265] ata2: SATA max UDMA/133 abar m2048@0xfb5fc000 port 
0xfb5fc180 irq 29 lpm-pol 0
[    7.435346] ata3: SATA max UDMA/133 abar m2048@0xfb5fc000 port 
0xfb5fc200 irq 29 lpm-pol 0
[    7.435428] ata4: SATA max UDMA/133 abar m2048@0xfb5fc000 port 
0xfb5fc280 irq 29 lpm-pol 0
[    7.435509] ata5: SATA max UDMA/133 abar m2048@0xfb5fc000 port 
0xfb5fc300 irq 29 lpm-pol 0
[    7.435591] ata6: SATA max UDMA/133 abar m2048@0xfb5fc000 port 
0xfb5fc380 irq 29 lpm-pol 0
[    7.441784] usbcore: registered new interface driver usbhid
[    7.441846] usbhid: USB HID core driver
[    7.500655] firewire_ohci 0000:0b:02.0: added OHCI v1.10 device as 
card 0, 4 IR + 8 IT contexts, quirks 0x11
[    7.508564] ACPI: bus type drm_connector registered
[    7.912692] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    7.913573] ata1.00: ATA-10: WD Blue SA510 2.5 2TB, 530309WD, max 
UDMA/133
[    7.913777] ata1.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 
32), AA
[    7.914559] ata1.00: Features: Dev-Sleep
[    7.915672] ata1.00: configured for UDMA/133
[    7.915946] scsi 0:0:0:0: Direct-Access     ATA      WD Blue SA510 2. 
09WD PQ: 0 ANSI: 5
[    7.916633] scsi 0:0:0:0: Attached scsi generic sg0 type 0
[    8.032959] firewire_core 0000:0b:02.0: created device fw0: GUID 
001e8c0001b0584a, S400
[    8.392705] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    8.404005] ata2.00: ATA-8: Corsair Force 3 SSD, 1.3.2, max UDMA/133
[    8.404390] ata2.00: 234441648 sectors, multi 16: LBA48 NCQ (depth 
32), AA
[    8.414420] ata2.00: configured for UDMA/133
[    8.414652] scsi 1:0:0:0: Direct-Access     ATA      Corsair Force 3  
2    PQ: 0 ANSI: 5
[    8.415258] scsi 1:0:0:0: Attached scsi generic sg1 type 0
[    8.892601] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    8.893431] ata3.00: ATA-10: WD Blue SA510 2.5 2TB, 530309WD, max 
UDMA/133
[    8.893585] ata3.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 
32), AA
[    8.894135] ata3.00: Features: Dev-Sleep
[    8.894803] ata3.00: configured for UDMA/133
[    8.895082] scsi 2:0:0:0: Direct-Access     ATA      WD Blue SA510 2. 
09WD PQ: 0 ANSI: 5
[    8.895648] scsi 2:0:0:0: Attached scsi generic sg2 type 0
[    9.372701] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    9.373996] ata4.00: ATA-8: ST3500418AS, CC38, max UDMA/133
[    9.374067] ata4.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 32)
[    9.375535] ata4.00: configured for UDMA/133
[    9.375859] scsi 3:0:0:0: Direct-Access     ATA ST3500418AS      CC38 
PQ: 0 ANSI: 5
[    9.376481] scsi 3:0:0:0: Attached scsi generic sg3 type 0
[    9.852705] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    9.852932] ata5.00: ATA-10: KINGSTON SA400S37480G, SBFKK1B3, max 
UDMA/133
[    9.853050] ata5.00: 937703088 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    9.853344] ata5.00: configured for UDMA/133
[    9.853667] scsi 4:0:0:0: Direct-Access     ATA      KINGSTON SA400S3 
K1B3 PQ: 0 ANSI: 5
[    9.854257] scsi 4:0:0:0: Attached scsi generic sg4 type 0
[   10.328735] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   10.330025] ata6.00: ATAPI: DRW-24F1ST   d, 2.00, max UDMA/133
[   10.331579] ata6.00: configured for UDMA/133
[   10.335320] scsi 5:0:0:0: CD-ROM            ASUS DRW-24F1ST   d   
2.00 PQ: 0 ANSI: 5
[   10.439755] sr 5:0:0:0: [sr0] scsi3-mmc drive: 48x/12x writer dvd-ram 
cd/rw xa/form2 cdda tray
[   10.439852] cdrom: Uniform CD-ROM driver Revision: 3.20
[   10.485719] sr 5:0:0:0: Attached scsi CD-ROM sr0
[   10.485854] sr 5:0:0:0: Attached scsi generic sg5 type 5
[   10.491823] scsi host6: pata_marvell
[   10.492266] scsi host7: pata_marvell
[   10.492425] ata7: PATA max UDMA/100 cmd 0xcc00 ctl 0xc880 bmdma 
0xc400 irq 16 lpm-pol 0
[   10.492515] ata8: PATA max UDMA/133 cmd 0xc800 ctl 0xc480 bmdma 
0xc408 irq 16 lpm-pol 0
[   10.492996] input: Logitech USB Multimedia Keyboard as 
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5.1/1-5.1:1.0/0003:046D:C317.0001/input/input5
[   10.499529] sd 0:0:0:0: [sda] 3907029168 512-byte logical blocks: 
(2.00 TB/1.82 TiB)
[   10.499631] sd 0:0:0:0: [sda] Write Protect is off
[   10.499669] sd 1:0:0:0: [sdc] 234441648 512-byte logical blocks: (120 
GB/112 GiB)
[   10.499691] sd 3:0:0:0: [sde] 976773168 512-byte logical blocks: (500 
GB/466 GiB)
[   10.499693] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   10.499699] sd 4:0:0:0: [sdb] 937703088 512-byte logical blocks: (480 
GB/447 GiB)
[   10.499700] sd 2:0:0:0: [sdd] 3907029168 512-byte logical blocks: 
(2.00 TB/1.82 TiB)
[   10.499707] sd 3:0:0:0: [sde] Write Protect is off
[   10.499710] sd 3:0:0:0: [sde] Mode Sense: 00 3a 00 00
[   10.499714] sd 4:0:0:0: [sdb] Write Protect is off
[   10.499717] sd 2:0:0:0: [sdd] Write Protect is off
[   10.499717] sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   10.499719] sd 2:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[   10.499731] sd 3:0:0:0: [sde] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   10.499743] sd 2:0:0:0: [sdd] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   10.499759] sd 4:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   10.499774] sd 3:0:0:0: [sde] Preferred minimum I/O size 512 bytes
[   10.499780] sd 2:0:0:0: [sdd] Preferred minimum I/O size 512 bytes
[   10.499786] sd 1:0:0:0: [sdc] Write Protect is off
[   10.499789] sd 1:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[   10.499805] sd 4:0:0:0: [sdb] Preferred minimum I/O size 512 bytes
[   10.499811] sd 1:0:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   10.499855] sd 1:0:0:0: [sdc] Preferred minimum I/O size 512 bytes
[   10.499872] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   10.499906] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[   10.552762] hid-generic 0003:046D:C317.0001: input,hidraw0: USB HID 
v1.10 Keyboard [Logitech USB Multimedia Keyboard] on 
usb-0000:00:1a.7-5.1/input0
[   10.553030] input: Logitech USB Multimedia Keyboard System Control as 
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5.1/1-5.1:1.1/0003:046D:C317.0002/input/input6
[   10.561189]  sdb: sdb1
[   10.561466] sd 4:0:0:0: [sdb] Attached SCSI disk
[   10.561627]  sda: sda1
[   10.561902] sd 0:0:0:0: [sda] Attached SCSI disk
[   10.564986]  sdc: sdc1 sdc2 sdc3
[   10.565349] sd 1:0:0:0: [sdc] Attached SCSI disk
[   10.565771] sd 2:0:0:0: [sdd] Attached SCSI disk
[   10.576768]  sde: sde1
[   10.577069] sd 3:0:0:0: [sde] Attached SCSI disk
[   10.612800] input: Logitech USB Multimedia Keyboard Consumer Control 
as 
/devices/pci0000:00/0000:00:1a.7/usb1/1-5/1-5.1/1-5.1:1.1/0003:046D:C317.0002/input/input7
[   10.613067] hid-generic 0003:046D:C317.0002: input,hidraw1: USB HID 
v1.10 Device [Logitech USB Multimedia Keyboard] on 
usb-0000:00:1a.7-5.1/input1
[   10.613372] input: SIGMACHIP Usb Mouse as 
/devices/pci0000:00/0000:00:1d.1/usb7/7-1/7-1:1.0/0003:1C4F:0034.0003/input/input8
[   10.613678] hid-generic 0003:1C4F:0034.0003: input,hidraw2: USB HID 
v1.10 Mouse [SIGMACHIP Usb Mouse] on usb-0000:00:1d.1-1/input0
[   18.428554] random: crng init done
[   24.060679] raid6: sse2x4   gen()  9574 MB/s
[   24.128687] raid6: sse2x2   gen() 11886 MB/s
[   24.196678] raid6: sse2x1   gen()  9703 MB/s
[   24.196756] raid6: using algorithm sse2x2 gen() 11886 MB/s
[   24.264681] raid6: .... xor() 7203 MB/s, rmw enabled
[   24.264739] raid6: using ssse3x2 recovery algorithm
[   24.267857] xor: measuring software checksum speed
[   24.268596]    prefetch64-sse  : 14790 MB/sec
[   24.269398]    generic_sse     : 13260 MB/sec
[   24.269455] xor: using function: prefetch64-sse (14790 MB/sec)
[   24.272286] async_tx: api initialized (async)
[   24.889111] Btrfs loaded, zoned=yes, fsverity=yes
[   25.105172] EXT4-fs (sdb1): mounted filesystem 
94072726-5fed-439f-a496-8e6aaa88617e ro with ordered data mode. Quota 
mode: none.
[   25.642164] systemd[1]: Inserted module 'autofs4'
[   25.714945] systemd[1]: systemd 249.11-0ubuntu3.12 running in system 
mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT 
+GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC 
+KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY -P11KIT -QRENCODE 
+BZIP2 +LZ4 +XZ +ZLIB +ZSTD -XKBCOMMON +UTMP +SYSVINIT 
default-hierarchy=unified)
[   25.716078] systemd[1]: Detected architecture x86-64.
[   26.215741] systemd[1]: Configuration file 
/run/systemd/system/netplan-ovs-cleanup.service is marked 
world-inaccessible. This has no effect as configuration data is 
accessible via APIs without restrictions. Proceeding anyway.
[   26.281296] systemd[1]: Accepting user/group name '${GNUNET_USER}', 
which does not match strict user/group name rules.
[   26.340090] systemd[1]: Queued start job for default target Friendly 
Recovery Mode.
[   26.378339] systemd[1]: Created slice Slice /system/modprobe.
[   26.379138] systemd[1]: Created slice Slice /system/systemd-fsck.
[   26.379537] systemd[1]: Set up automount Arbitrary Executable File 
Formats File System Automount Point.
[   26.379826] systemd[1]: Reached target Slice Units.
[   26.380048] systemd[1]: Reached target Local Verity Protected Volumes.
[   26.380336] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[   26.380724] systemd[1]: Listening on LVM2 poll daemon socket.
[   26.386624] systemd[1]: Listening on RPCbind Server Activation Socket.
[   26.388485] systemd[1]: Listening on Process Core Dump Socket.
[   26.388926] systemd[1]: Listening on fsck to fsckd communication Socket.
[   26.389212] systemd[1]: Listening on initctl Compatibility Named Pipe.
[   26.389683] systemd[1]: Listening on Journal Audit Socket.
[   26.390024] systemd[1]: Listening on Journal Socket (/dev/log).
[   26.390392] systemd[1]: Listening on Journal Socket.
[   26.390766] systemd[1]: Listening on udev Control Socket.
[   26.391077] systemd[1]: Listening on udev Kernel Socket.
[   26.392423] systemd[1]: Mounting Huge Pages File System...
[   26.393759] systemd[1]: Mounting POSIX Message Queue File System...
[   26.395047] systemd[1]: Mounting Kernel Debug File System...
[   26.396347] systemd[1]: Mounting Kernel Trace File System...
[   26.398876] systemd[1]: Starting Journal Service...
[   26.399209] systemd[1]: Finished Availability of block devices.
[   26.401010] systemd[1]: Starting Set the console keyboard layout...
[   26.402472] systemd[1]: Starting Create List of Static Device Nodes...
[   26.403878] systemd[1]: Starting Monitoring of LVM2 mirrors, 
snapshots etc. using dmeventd or progress polling...
[   26.405439] systemd[1]: Starting Load Kernel Module configfs...
[   26.407638] systemd[1]: Starting Load Kernel Module efi_pstore...
[   26.409594] systemd[1]: Starting Load Kernel Module fuse...
[   26.412010] systemd[1]: Starting Set console scheme...
[   26.412341] systemd[1]: Condition check resulted in File System Check 
on Root Device being skipped.
[   26.416258] systemd[1]: Starting Load Kernel Modules...
[   26.417898] systemd[1]: Starting Remount Root and Kernel File Systems...
[   26.419268] systemd[1]: Starting Coldplug All udev Devices...
[   26.421826] systemd[1]: Mounted Huge Pages File System.
[   26.422134] systemd[1]: Mounted POSIX Message Queue File System.
[   26.422435] systemd[1]: Mounted Kernel Debug File System.
[   26.422730] systemd[1]: Mounted Kernel Trace File System.
[   26.423406] systemd[1]: Finished Create List of Static Device Nodes.
[   26.423950] systemd[1]: modprobe@configfs.service: Deactivated 
successfully.
[   26.424325] systemd[1]: Finished Load Kernel Module configfs.
[   26.424935] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[   26.425310] systemd[1]: Finished Load Kernel Module fuse.
[   26.426000] systemd[1]: Finished Set console scheme.
[   26.427476] systemd[1]: Mounting FUSE Control File System...
[   26.428783] systemd[1]: Mounting Kernel Configuration File System...
[   26.430055] systemd[1]: Mounted FUSE Control File System.
[   26.431047] systemd[1]: Mounted Kernel Configuration File System.
[   26.452596] systemd[1]: modprobe@efi_pstore.service: Deactivated 
successfully.
[   26.453082] systemd[1]: Finished Load Kernel Module efi_pstore.
[   26.481043] lp: driver loaded but no devices found
[   26.482617] EXT4-fs (sdb1): re-mounted 
94072726-5fed-439f-a496-8e6aaa88617e r/w. Quota mode: none.
[   26.484351] systemd[1]: Finished Remount Root and Kernel File Systems.
[   26.484758] systemd[1]: Condition check resulted in Platform 
Persistent Storage Archival being skipped.
[   26.486587] systemd[1]: Starting Load/Save Random Seed...
[   26.488505] systemd[1]: Starting Create System Users...
[   26.492900] ppdev: user-space parallel port driver
[   26.503561] systemd[1]: Finished Load/Save Random Seed.
[   26.503986] systemd[1]: Condition check resulted in First Boot 
Complete being skipped.
[   26.508889] systemd[1]: Finished Create System Users.
[   26.510949] systemd[1]: Starting Create Static Device Nodes in /dev...
[   26.512109] systemd[1]: Finished Set the console keyboard layout.
[   26.518878] systemd[1]: Finished Monitoring of LVM2 mirrors, 
snapshots etc. using dmeventd or progress polling.
[   26.523549] systemd[1]: Finished Load Kernel Modules.
[   26.525607] systemd[1]: Starting Apply Kernel Variables...
[   26.527740] systemd[1]: Finished Create Static Device Nodes in /dev.
[   26.528115] systemd[1]: Reached target Preparation for Local File 
Systems.
[   26.531352] systemd[1]: Starting Rule-based Manager for Device Events 
and Files...
[   26.553983] systemd[1]: Finished Apply Kernel Variables.
[   26.554309] systemd[1]: Started Journal Service.
[   26.561688] systemd-journald[401]: Received client request to flush 
runtime journal.
[   26.974449] i5500_temp 0000:00:14.3: Sensor seems to be disabled
[   26.975439] EDAC MC0: Giving out device to module i7core_edac.c 
controller i7 core #0: DEV 0000:ff:03.0 (INTERRUPT)
[   26.986120] EDAC PCI0: Giving out device to module i7core_edac 
controller EDAC PCI controller: DEV 0000:ff:03.0 (POLLED)
[   26.986154] EDAC i7core: Driver loaded, 1 memory controller(s) found.
[   27.582802] mc: Linux media interface: v0.10
[   27.647535] kvm_intel: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL does not 
work properly. Using workaround
[   27.825013] videodev: Linux video capture interface: v2.00
[   27.889975] snd_hda_intel 0000:04:00.1: Force to non-snoop mode
[   27.924703] input: HDA ATI HDMI HDMI/DP,pcm=3 as 
/devices/pci0000:00/0000:00:03.0/0000:02:00.0/0000:03:00.0/0000:04:00.1/sound/card1/input10
[   27.924806] input: HDA ATI HDMI HDMI/DP,pcm=7 as 
/devices/pci0000:00/0000:00:03.0/0000:02:00.0/0000:03:00.0/0000:04:00.1/sound/card1/input11
[   27.943013] EXT4-fs (sde1): mounted filesystem 
269c3cb0-82a8-484f-9f96-2569d52ced08 r/w with ordered data mode. Quota 
mode: none.
[   27.967579] EXT4-fs (sdc3): mounted filesystem 
965f3d65-ec1b-49a8-a27a-a6989cecf661 r/w with ordered data mode. Quota 
mode: none.
[   27.994822] Adding 15625212k swap on /dev/sdc2.  Priority:-2 
extents:1 across:15625212k SS
[   28.012663] Registered IR keymap rc-rc6-mce
[   28.026581] EXT4-fs (sda1): mounted filesystem 
a7d8e4b2-e2df-4976-b661-37e48f7411cf r/w with ordered data mode. Quota 
mode: none.
[   28.030789] EXT4-fs (sdd): mounted filesystem 
7f49ad40-e533-42c4-9977-7c4809d47b3d r/w with ordered data mode. Quota 
mode: none.
[   28.064041] IR RC6 protocol handler initialized
[   28.128766] rc rc0: Media Center Ed. eHome Infrared Remote 
Transceiver as /devices/pci0000:00/0000:00:1d.0/usb6/6-1/6-1:1.0/rc/rc0
[   28.128872] rc rc0: lirc_dev: driver mceusb registered at minor = 0, 
raw IR receiver, raw IR transmitter
[   28.128938] input: Media Center Ed. eHome Infrared Remote Transceiver 
as /devices/pci0000:00/0000:00:1d.0/usb6/6-1/6-1:1.0/rc/rc0/input9
[   28.201516] usb 1-5.2: current rate 16000 is different from the 
runtime rate 48000
[   28.349559] mceusb 6-1:1.0: long-range (0x1) receiver active
[   28.375543] snd_hda_codec_analog hdaudioC0D0: autoconfig for AD1989B: 
line_outs=4 (0x12/0x16/0x24/0x25/0x0) type:line
[   28.375552] snd_hda_codec_analog hdaudioC0D0:    speaker_outs=0 
(0x0/0x0/0x0/0x0/0x0)
[   28.375554] snd_hda_codec_analog hdaudioC0D0:    hp_outs=1 
(0x11/0x0/0x0/0x0/0x0)
[   28.375557] snd_hda_codec_analog hdaudioC0D0:    mono: mono_out=0x0
[   28.375558] snd_hda_codec_analog hdaudioC0D0: dig-out=0x1b/0x1d
[   28.375560] snd_hda_codec_analog hdaudioC0D0:    inputs:
[   28.375562] snd_hda_codec_analog hdaudioC0D0:      Rear Mic=0x17
[   28.375564] snd_hda_codec_analog hdaudioC0D0:      Front Mic=0x14
[   28.375566] snd_hda_codec_analog hdaudioC0D0:      Line=0x15
[   28.375568] snd_hda_codec_analog hdaudioC0D0:      CD=0x18
[   28.394464] input: HDA Intel Rear Mic as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input12
[   28.394566] input: HDA Intel Front Mic as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input13
[   28.394668] input: HDA Intel Line as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input14
[   28.394767] input: HDA Intel Line Out Front as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input15
[   28.394869] input: HDA Intel Line Out Surround as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input16
[   28.394975] input: HDA Intel Line Out CLFE as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input17
[   28.395067] input: HDA Intel Line Out Side as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input18
[   28.395162] input: HDA Intel Front Headphone as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input19
[   28.412646] mceusb 6-1:1.0: Registered Topseed eHome Infrared 
Transceiver with mce emulator interface version 1
[   28.412654] mceusb 6-1:1.0: 2 tx ports (0x3 cabled) and 2 rx sensors 
(0x1 active)
[   28.412710] usbcore: registered new interface driver mceusb
[   28.438310] cfg80211: Loading compiled-in X.509 certificates for 
regulatory database
[   28.438792] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   28.439110] Loaded X.509 cert 'wens: 
61c038651aabdcf94bd0ac7ff06c7248db18c600'
[   28.607708] usb 1-5.2: current rate 16000 is different from the 
runtime rate 24000
[   28.614091] usb 1-5.2: current rate 16000 is different from the 
runtime rate 32000
[   28.655794] cx23885: cx23885 driver version 0.0.4 loaded
[   28.655991] cx23885: CORE cx23885[0]: subsystem: 0070:7801, board: 
Hauppauge WinTV-HVR1800 [card=2,autodetected]
[   28.718778] usbcore: registered new interface driver snd-usb-audio
[   28.718930] usb 1-5.2: Found UVC 1.00 device Razer Kiyo Pro (1532:0e05)
[   28.723120] usbcore: registered new interface driver uvcvideo
[   29.100579] tveeprom: Hauppauge model 78521, rev C1E9, serial# 4029759297
[   29.100587] tveeprom: MAC address is 00:0d:fe:31:3f:41
[   29.100589] tveeprom: tuner model is Philips 18271_8295 (idx 149, 
type 54)
[   29.100591] tveeprom: TV standards NTSC(M) ATSC/DVB Digital (eeprom 0x88)
[   29.100594] tveeprom: audio processor is CX23887 (idx 42)
[   29.100596] tveeprom: decoder processor is CX23887 (idx 37)
[   29.100597] tveeprom: has radio
[   29.100599] cx23885: cx23885[0]: hauppauge eeprom: model=78521
[   29.134478] audit: type=1400 audit(1726501579.008:2): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="/usr/bin/lxc-start" pid=1345 comm="apparmor_parser"
[   29.167756] audit: type=1400 audit(1726501579.040:3): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="lsb_release" pid=1339 comm="apparmor_parser"
[   29.168230] audit: type=1400 audit(1726501579.040:4): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="nvidia_modprobe" pid=1342 comm="apparmor_parser"
[   29.168237] audit: type=1400 audit(1726501579.040:5): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="nvidia_modprobe//kmod" pid=1342 comm="apparmor_parser"
[   29.190465] audit: type=1400 audit(1726501579.064:6): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="/usr/bin/man" pid=1346 comm="apparmor_parser"
[   29.190479] audit: type=1400 audit(1726501579.064:7): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="man_filter" pid=1346 comm="apparmor_parser"
[   29.190486] audit: type=1400 audit(1726501579.064:8): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="man_groff" pid=1346 comm="apparmor_parser"
[   29.227777] audit: type=1400 audit(1726501579.100:9): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="lxc-container-default" pid=1340 comm="apparmor_parser"
[   29.227788] audit: type=1400 audit(1726501579.100:10): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="lxc-container-default-cgns" pid=1340 comm="apparmor_parser"
[   29.227793] audit: type=1400 audit(1726501579.100:11): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="lxc-container-default-with-mounting" pid=1340 comm="apparmor_parser"
[   29.231700] cx25840 2-0044: cx23887 A/V decoder found @ 0x88 (cx23885[0])
[   29.560560] usb 3-4: reset high-speed USB device number 4 using ehci-pci
[   29.727576] ieee80211 phy0: rt2x00_set_rt: Info - RT chipset 3071, 
rev 021c detected
[   29.755955] ieee80211 phy0: rt2x00_set_rf: Info - RF chipset 0008 
detected
[   29.756340] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
[   29.757100] usbcore: registered new interface driver rt2800usb
[   29.778459] rt2800usb 3-4:1.0 wlx20cf30a24130: renamed from wlan0
[   29.895735] cx25840 2-0044: loaded v4l-cx23885-avcore-01.fw firmware 
(16382 bytes)
[   30.037066] tuner: 1-0042: Tuner -1 found with type(s) Radio TV.
[   30.081659] tda829x 1-0042: could not clearly identify tuner address, 
defaulting to 60
[   30.108977] tda18271 1-0060: creating new instance
[   30.157067] tda18271: TDA18271HD/C1 detected @ 1-0060
[   30.692980] tda829x 1-0042: type set to tda8295+18271
[   32.046907] cx23885: cx23885[0]: registered device video2 [v4l2]
[   32.046974] cx23885: cx23885[0]: registered device vbi0
[   32.047137] cx23885: cx23885[0]: alsa: registered ALSA audio device
[   32.047225] cx23885: cx23885[0]: registered device video3 [mpeg]
[   32.047241] cx23885: Firmware and/or mailbox pointer not initialized 
or corrupted, signature = 0xbfbbb9fb, cmd = PING_FW
[   32.048135] cx23885 0000:09:00.0: Direct firmware load for 
v4l-cx23885-enc.fw failed with error -2
[   32.048142] cx23885: ERROR: Hotplug firmware request failed 
(v4l-cx23885-enc.fw).
[   32.048143] cx23885: Please fix your hotplug setup, the board will 
not work without firmware loaded!
[   32.048144] cx23885: cx23885_initialize_codec() f/w load failed
[   32.048146] cx23885: cx23885_dvb_register() allocating 1 frontend(s)
[   32.048148] cx23885: cx23885[0]: cx23885 based dvb card
[   32.095985] MT2131: successfully identified at address 0x61
[   32.097631] dvbdev: DVB: registering new adapter (cx23885[0])
[   32.097636] cx23885 0000:09:00.0: DVB: registering adapter 0 frontend 
0 (Samsung S5H1409 QAM/8VSB Frontend)...
[   32.098129] cx23885: cx23885_dev_checkrevision() Hardware revision = 0xb1
[   32.098134] cx23885: cx23885[0]/0: found at 0000:09:00.0, rev: 15, 
irq: 17, latency: 0, mmio: 0xfbc00000
[   42.409208] sky2 0000:06:00.0 enp6s0: enabling interface
[   42.415708] sky2 0000:08:00.0 enp8s0: enabling interface
[   42.418426] ieee80211 phy0: rt2x00lib_request_firmware: Info - 
Loading firmware file 'rt2870.bin'
[   42.420480] ieee80211 phy0: rt2x00lib_request_firmware: Info - 
Firmware detected - version: 0.36
[   44.751240] wlx20cf30a24130: authenticate with fc:2b:b2:a7:af:02 
(local address=20:cf:30:a2:41:30)
[   44.751249] wlx20cf30a24130: send auth to fc:2b:b2:a7:af:02 (try 1/3)
[   44.753867] wlx20cf30a24130: authenticated
[   44.756702] wlx20cf30a24130: associate with fc:2b:b2:a7:af:02 (try 1/3)
[   44.760301] wlx20cf30a24130: RX AssocResp from fc:2b:b2:a7:af:02 
(capab=0x1411 status=0 aid=3)
[   44.770005] wlx20cf30a24130: associated
[   44.849872] wlx20cf30a24130: Limiting TX power to 30 (30 - 0) dBm as 
advertised by fc:2b:b2:a7:af:02
[   45.366207] sky2 0000:06:00.0 enp6s0: Link is up at 1000 Mbps, full 
duplex, flow control both

On 2024-09-16 05:12, Dr. David Alan Gilbert wrote:
> * Bob Gill (gillb5@telus.net) wrote:
>> Addendum: I have a portion of /var/log/syslog of the 6.11-rc7 kernel, which
>> contains a coredump, and
>>
>> another line: Sep  8 20:13:06 freedom kernel: [  566.359456] ACPI:
>> \_SB_.PCI0.SBRG.ASOC: Device cannot be configured due to a frequency
>> mismatch
>>
>> any takers?
> Not my field specifically; but I think a dmesg from the working one
> and the failing one to compare would help people.
>
> Dave
>
>> On 2024-09-15 14:59, Bob Gill wrote:
>>> So 6.10.0 runs ok.  6.11.0-rc1 was the first kernel that started
>>> crashing.  Every rc after, including 6.11.0 all crash.
>>>
>>> By that I mean it seems the startup is ok, but when it comes to the X
>>> server, when it tries to start, it crashes (and takes everything else
>>> along with it).
>>>
>>> I ran recovery kernel, enabled networking, dropped into terminal.
>>>
>>> service --status-all | grep lightdm gave:
>>>
>>> [ - ]  lightdm
>>>
>>> Portions of Xorg.0.log:
>>>
>>> cat Xorg.0.log | grep EE
>>>
>>> [    61.679] Current Operating System: Linux freedom 6.11.0 #1 SMP
>>> PREEMPT_DYNAMIC Sun Sep 15 13:10:55 MDT 2024 x86_64
>>>      (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
>>> [    61.809] (EE) systemd-logind: failed to get session: PID 2028 does
>>> not belong to any known session
>>> [    61.913] (EE) open /dev/dri/card0: No such file or directory
>>> [    61.913] (EE) open /dev/dri/card0: No such file or directory
>>> [    61.914] (EE) Unable to find a valid framebuffer device
>>> [    61.914] (EE) open /dev/fb0: No such file or directory
>>> [    61.914] (EE) Screen 0 deleted because of no matching config section.
>>> [    61.914] (EE) Screen 0 deleted because of no matching config section.
>>>
>>>
>>>  From the terminal, I can't run 'service lightdm start' and get back to
>>> any state.  pressing ctrl-alt-(f1-f9) does nothing. Pressing the
>>> caps-lock button on/off on the keyboard stops responding immediately.
>>> Even the power/reset buttons on the case do nothing.  I have to hit the
>>> power switch.  The kernel crashes hard.
>>>
>>> My graphics hardware (taken from 6.10.0):
>>>
>>> inxi -G
>>>
>>> Graphics:
>>>    Device-1: AMD driver: amdgpu v: kernel
>>>    Device-2: Conexant Systems CX23887/8 PCIe Broadcast Audio and Video
>>>      Decoder with 3D Comb
>>>      driver: cx23885 v: 0.0.4
>>>    Device-3: Razer USA Kiyo Pro type: USB driver: snd-usb-audio,uvcvideo
>>>    Device-4: Realtek RTL2838 DVB-T type: USB driver: N/A
>>>    Display: x11 server: X.Org v: 1.21.1.4 driver: X: loaded: amdgpu,ati
>>>      unloaded: fbdev,modesetting,radeon,vesa gpu: amdgpu resolution:
>>>      1: 1920x1080~60Hz 2: 1920x1080~60Hz
>>>    OpenGL:
>>>      renderer: AMD Radeon RX 6500 XT (navi24 LLVM 15.0.7 DRM 3.57
>>> 6.10.0-rc7+)
>>>      v: 4.6 Mesa 23.2.1-1ubuntu3.1~22.04.2
>>>
>>>
>>> There is a weird line from /var/log/Xorg.0.log.old:
>>>
>>> [   299.900] (++) using VT number 7
>>>
>>> [   299.900] (II) systemd-logind: logind integration requires -keeptty
>>> and -keeptty was not provided, disabling logind integration
>>> [   299.908] (--) PCI:*(4@0:0:0) 1002:743f:148c:2415 rev 193, Mem @
>>> 0xd0000000/268435456, 0xcfe00000/2097152, 0xfb700000/1048576, I/O @
>>> 0x0000a000/256, B
>>> IOS @ 0x????????/131072
>>> [   299.908] (--) PCI: (9@0:0:0) 14f1:8880:0070:7801 rev 15, Mem @
>>> 0xfbc00000/2097152
>>> [   299.908] (II) LoadModule: "glx"
>>>
>>> I don't know why the BIOS line looks like: BIOS @ 0x????????/131072
>>>
>>> Is that normal or did it not find it?
>>>
>>>
>>> Sure, its a corner case.  I might be the only one on the planet with
>>> this problem.  Or maybe not.
>>>
>>> I have been using a standard .config for building kernels for a while
>>> now.  Please reply to me directly as I'm not on the list.
>>>
>>> Bob
>>>
>>>
>>>
>>>
>>>

