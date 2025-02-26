Return-Path: <linux-kernel+bounces-533388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C25BA4596E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2DBE1890011
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241C722425A;
	Wed, 26 Feb 2025 09:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="YVTWjluY"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8690420AF8E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740560779; cv=none; b=jPE7eOdYBOFMYCymC/qjP4ZX4GhPluOIkB5ujYRVPoybqfC8l9d4UJcYO/Kfh0wopkBm6yhndcuywIimdYC+X8S0/NFO5UuXB4dXpbwtHVSDH0UBFMQTW/uzft5uAzzWnEcK12qe/Gj/e2C4VWJplyuCjekGu/v/uIiNnLmqdu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740560779; c=relaxed/simple;
	bh=8Y+SH4RKeR3fsA/CbY4I4G95dSHDHAjuH6FzLaVVm+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VHfKQKMa/gYntLb8NIgE8ELTqOwZwxW3KnkKKfrg9wXBy/VV/vsnWzh3wus/C+1OGmSFQPJ8c+ucjPGgu4bsRX9iapU03YDMhld70FqoCwKxGGJ+Mgkg15teRuYatkGxrrHcwm9AWrXGYq5prpWIvGuSEXFjcQayh3PbhjFT5rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=YVTWjluY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4398c8c8b2cso65494505e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 01:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740560773; x=1741165573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wFqjJ5s+Z0xnd9r2pX3ADIi2my/okJGh5BKAReVcsKc=;
        b=YVTWjluY7aEoD9sE/nq0TPb2uZOwNA1VEheNONAEimp9VVAWg/FHF0cI9TjLUnafYI
         PHL61ydoyN0eTbpEwNb4jWt56OwNYPwu0mpuexx4rlfQmL5X8cYQqPCyHdoSTuuzKL8i
         vyVE0/QKbRg5b8HZMvShKpSSmYWxraXdO946b7asRcou1CgCaCR287uF4n+SjsNkTKOu
         71TzCklAf0HeSC53anCH60oZ4vqsmkhNwb5FqKS9MpemuIIjmNyQ+lmaPpCv3b3MdNpi
         faZ+r6ukh2zzxdCr6cMrBgQUf5NOcmhPKsszIc7JDi4+eHTsHbuYDcn9D81Mb/pk0Wog
         5Vgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740560773; x=1741165573;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wFqjJ5s+Z0xnd9r2pX3ADIi2my/okJGh5BKAReVcsKc=;
        b=wkywFbJPOSpKmpSYZoJNhanuKCUHEZ7NrenlIZR4N1VIBGMclnl3kMPN6Q358Ul/8u
         eO9hZDo01EOGJJX1w4sd8lW7qVibaiBDyTmjyjs8RGGK6H6fkeeWsUM8F4WXUN4IijaD
         XwJWC+Ryk+wM23C6eItgz+Mi9EE2IMkNh4Guue2zTq+P7XV+GMDTyKumCK6wIvvbMHNJ
         Mxuf93eeJhl4MIF2ewHUfSfJI6KLliChMUhW05N5fzNULrHYOsthWF5qvBJ3kL0O2TA0
         II8etDoPFFeUirgXri9FQrNlYSjMZS1wdTDz1t6UY1YqinrLY2h+BJMaY7HVvPXdPMrv
         bdRg==
X-Forwarded-Encrypted: i=1; AJvYcCV6NkbiiNNw7fpmt6/9VaDI2uOmD/2MtLLTTRmYgoAOQFSn26/Ds7kCF3J0cYV8h2STNidREXdgRyCV0C8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNLMSU9FviAFxgqUJ2DUIm2Qy9OC9g8VJK45OyDGbeLxhSAikc
	/FdEBMbjNUbQzpPvlfOpg5BhI2hdaDN6++Lx8UMd1IdJ3J10CuOBO13LM++SmXE=
X-Gm-Gg: ASbGncsWrF8o/VVaEzsCyTAFifswaG8zM06xhJxpzXdLgb4V5nWIx85zwQzXu1gqI3r
	/oPywBjDCrXqrTkdHYDdrEXhvweBWI0n+sI6f9Ia33vLPP8ledjfAamQLFjGl3NR9yfz3w++PNX
	IEMS+hA7bOt9W9X8McqnRSBTG1vO7RWHqb9P4wirzas5tlpsJW5Qn7n+TyK6C2w8uW1wTIKTAR8
	5m+MaMthWXgntH7Y+PQsiWdOcz4AdRJlMNRdnC5Rj1hrCtc/+9QBspitDPNRJys1eJIx8FaXB7V
	VJ12JWB4mkLnIPMtNkyBP7l33MZB13L78A==
X-Google-Smtp-Source: AGHT+IF2jL/6HEshRKQgvDuJGZdSFLJT33KiaiMqikmoObJ0F4VSY/h7X0zQKfIsnmcQGTgCryyo3w==
X-Received: by 2002:a05:600c:190c:b0:439:3d5c:8c19 with SMTP id 5b1f17b1804b1-43ab0f6440emr52386245e9.24.1740560773326;
        Wed, 26 Feb 2025 01:06:13 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba52b7ecsm13869615e9.3.2025.02.26.01.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 01:06:12 -0800 (PST)
Message-ID: <7dd5a0a2-4f56-48b4-8861-c7d75754faab@tuxon.dev>
Date: Wed, 26 Feb 2025 11:06:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] AT91 Clock Adjustments
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, mripard@kernel.org
References: <cover.1738864727.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <cover.1738864727.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06.02.2025 20:14, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> This set has clock system adjustments for the AT91 clock system.
> 
> The first is to adjust the slow clock driver to account for the updated
> DT node-naming for clocks and xtals and ensuring the driver is still
> backwards compatible.
> 
> The second is a adding a missing clk_hw struct that is not added into
> parent_data struct causing a incorrect parent for main_osc.
> 
> Ryan Wanner (2):
>   clk: at91: sckc: Fix parent_data struct for slow osc
>   clk: at91: sama7d65: Add missing clk_hw to parent_data
> 
>  drivers/clk/at91/sama7d65.c |  1 +
>  drivers/clk/at91/sckc.c     | 12 ++++++------
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 

There are boot failures on sama7g5 with this series on top of at91-next and
the following diff on sama7g5 dts to mimic the sama7d65 use case:

diff --git a/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
b/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
index 0f5e6ad438dd..1bce9f999431 100644
--- a/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
@@ -35,16 +35,6 @@ aliases {
                i2c2 = &i2c9;
        };

-       clocks {
-               slow_xtal {
-                       clock-frequency = <32768>;
-               };
-
-               main_xtal {
-                       clock-frequency = <24000000>;
-               };
-       };
-
        gpio-keys {
                compatible = "gpio-keys";

@@ -132,6 +122,15 @@ spdif_out: spdif-out {
        };
 };

+&slow_xtal {
+       clock-frequency = <32768>;
+};
+
+&main_xtal {
+       clock-frequency = <24000000>;
+};
+
+
 &adc {
        vddana-supply = <&vddout25>;
        vref-supply = <&vddout25>;
diff --git a/arch/arm/boot/dts/microchip/sama7g5.dtsi
b/arch/arm/boot/dts/microchip/sama7g5.dtsi
index 17bcdcf0cf4a..3158c2f0b4c0 100644
--- a/arch/arm/boot/dts/microchip/sama7g5.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7g5.dtsi
@@ -117,12 +117,12 @@ map1 {
        };

        clocks {
-               slow_xtal: slow_xtal {
+               slow_xtal: clk-slowxtal {
                        compatible = "fixed-clock";
                        #clock-cells = <0>;
                };

-               main_xtal: main_xtal {
+               main_xtal: clk-mainxtal {
                        compatible = "fixed-clock";
                        #clock-cells = <0>;
                };

I've identified the following:


cpu cpu0: _opp_config_clk_single: failed to set clock rate: -22
cpufreq: __target_index: Failed to change cpu frequency: -22
------------[ cut here ]------------
kernel BUG at drivers/cpufreq/cpufreq.c:1523!
Internal error: Oops - BUG: 0 [#1] ARM
Modules linked in:
CPU: 0 UID: 0 PID: 1 Comm: swapper Not tainted 6.14.0-rc1+ #11
Hardware name: Microchip SAMA7
PC is at cpufreq_online+0x8d8/0xa30
LR is at __wake_up+0x20/0x30
pc : [<c063cca0>]    lr : [<c0151254>]    psr: a0000013
sp : e0821d30  ip : 00000000  fp : c0e50508
r10: c434830c  r9 : c4348204  r8 : c0e97230
r7 : c4348264  r6 : 00000000  r5 : 000ca511  r4 : c4348200
r3 : 047e0d67  r2 : 047e0d67  r1 : 00000003  r0 : ffffffea
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c53c7d  Table: 60004059  DAC: 00000051
Register r0 information: non-paged memory
Register r1 information: non-paged memory
Register r2 information: non-paged memory
Register r3 information: non-paged memory
Register r4 information: slab kmalloc-512 start c4348200 pointer offset 0
size 512
Register r5 information: non-paged memory
Register r6 information: NULL pointer
Register r7 information: slab kmalloc-512 start c4348200 pointer offset 100
size 512
Register r8 information: non-slab/vmalloc memory
Register r9 information: slab kmalloc-512 start c4348200 pointer offset 4
size 512
Register r10 information: slab kmalloc-512 start c4348200 pointer offset
268 size 512
Register r11 information: non-slab/vmalloc memory
Register r12 information: NULL pointer
Process swapper (pid: 1, stack limit = 0x08d7ca6b)
Stack: (0xe0821d30 to 0xe0822000)
1d20:                                     00000000 e0821d98 c4348208 c0c00250
1d40: 00000001 00000000 e0821d98 c0e50508 c4048000 00000000 c406f480 c4048000
1d60: c4341ec0 c0e50508 c4341ec8 c063ce8c c0e593a8 c4048000 c406f4bc c406f480
1d80: c4048000 c04c8bb0 c406f4cc c40704b0 00000000 047e0d67 3b9aca03 c0e5986c
1da0: c0e5931c c0e97230 00000000 c063a618 00000000 c4048000 c0e59858 c40d0a10
1dc0: c0e597f0 c063f80c c0d31830 00000000 00000000 00000000 00000000 00000000
1de0: 00000000 00000000 e0821df4 00000000 00000000 c0ba32fc 00000000 047e0d67
1e00: c40d75d8 00000000 c40d0a10 c0e59804 00000000 00000000 c0d31830 c0c2b5a0
1e20: c0c776b0 c04cc8dc c40d0a10 00000000 c0e59804 c04ca1f4 c40d0a10 c0e59804
1e40: c40d0a10 00000000 00000000 c04ca47c 00000000 c0be8598 c0e94b28 c0e59804
1e60: c40d0a10 00000000 00000000 c04ca658 c40d0a10 c0e59804 c40d0a54 c4048000
1e80: 00000000 c04ca8c4 c0e59804 c04ca834 c406f3c0 c04c8494 c4048000 c406f40c
1ea0: c4070d30 047e0d67 c0e59804 c4341e00 00000000 c406f3c0 c4341e34 c04c959c
1ec0: c0c00c14 c0e6c000 c0e59804 c0d2113c c4070800 00000000 c0e6c000 c04cb598
1ee0: c4048000 c0d2113c c4070800 c010d21c 000003c0 00000000 c407084e c4070800
1f00: c407084d c013e9e0 c0bee764 000000c0 00000000 00000000 c0d004d0 c4048000
1f20: 00000006 00000006 373126cc c407086a 00000000 047e0d67 00000012 047e0d67
1f40: 00000007 c0d42bd8 00000007 c4070800 000000c0 c0d31850 c0d31830 c0d011f4
1f60: 00000006 00000006 00000000 c0d004d0 e0821f6c c0d004d0 00000000 c0e03380
1f80: c0905828 00000000 00000000 00000000 00000000 00000000 00000000 c0905844
1fa0: 00000000 c0905828 00000000 c010014c 00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
Call trace:
 cpufreq_online from cpufreq_add_dev+0x84/0x94
 cpufreq_add_dev from subsys_interface_register+0xf0/0x108
 subsys_interface_register from cpufreq_register_driver+0x13c/0x2e4
 cpufreq_register_driver from dt_cpufreq_probe+0xb4/0x380
 dt_cpufreq_probe from platform_probe+0x5c/0xb8
 platform_probe from really_probe+0xc8/0x2c8
 really_probe from __driver_probe_device+0x88/0x19c
 __driver_probe_device from driver_probe_device+0x30/0x104
 driver_probe_device from __driver_attach+0x90/0x178
 __driver_attach from bus_for_each_dev+0x6c/0xb4
 bus_for_each_dev from bus_add_driver+0xcc/0x1ec
 bus_add_driver from driver_register+0x7c/0x114
 driver_register from do_one_initcall+0x40/0x21c
 do_one_initcall from kernel_init_freeable+0x194/0x1f8
 kernel_init_freeable from kernel_init+0x1c/0x128
 kernel_init from ret_from_fork+0x14/0x28
Exception stack(0xe0821fb0 to 0xe0821ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
Code: e3a02000 ebfff87e e3500000 0a000043 (e7f001f2)
---[ end trace 0000000000000000 ]---
note: swapper[1] exited with irqs disabled
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
---[ end Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b ]---


And this one:

Starting kernel ...

Booting Linux on physical CPU 0x0
Linux version 6.14.0-rc1+ (claudiu@claudiu-X670E-Pro-RS)
(arm-none-linux-gnueabihf-gcc (GNU Toolchain for the A-profile Architecture
10.3-2021.07 (arm-10.29)) 10.3.1 20210621, GNU ld (GNU Toolchain for the
A-profile Architecture 10.3-2021.07 (arm-10.29)) 2.36.1.20210621) #11 Wed
Feb 26 11:01:10 EET 2025
CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
OF: fdt: Machine model: Microchip SAMA7G5-EK
printk: legacy bootconsole [earlycon0] enabled
Memory policy: Data cache writeback
cma: Reserved 192 MiB at 0x70000000 on node -1
Zone ranges:
  Normal   [mem 0x0000000060000000-0x000000007fffffff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000060000000-0x000000007fffffff]
Initmem setup node 0 [mem 0x0000000060000000-0x000000007fffffff]
OF: reserved mem: Reserved memory: No reserved-memory node in the DT
CPU: All CPU(s) started in SVC mode.
Kernel command line: console=ttyS0,115200 root=/dev/mmcblk1p2
rootfstype=ext4 rw rootwait cma=192m atmel.pm_modes=standby,ulp0 earlyprintk
printk: log buffer data + meta data: 65536 + 204800 = 270336 bytes
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes, linear)
Built 1 zonelists, mobility grouping on.  Total pages: 131072
mem auto-init: stack:off, heap alloc:off, heap free:off
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
Main crystal frequency not set, using approximate value
timer_probe: no matching timers found
Console: colour dummy device 80x30
sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every
21474836475000000ns


I suspect parent_data in sama7g5_pmc_setup() need to be initialized with zero.

Thank you,
Claudiu




