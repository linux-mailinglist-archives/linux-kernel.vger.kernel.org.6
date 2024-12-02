Return-Path: <linux-kernel+bounces-428055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4599E0980
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ADBE281855
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DBD1DAC90;
	Mon,  2 Dec 2024 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3X/4k+W"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531401D95AA
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159542; cv=none; b=cI9+dYWC40ZQZwQi8bpu4TI6yfQEphH27uj8RL6ehk5zUXSiwSvyiUg7g7GfhQl1A73zsbiyNhGGnktBa3ZXqXqP002LWdW8T8id4SdKdsx6lCWDGg9qLWpkhXZ/IBJWLzz5ytH9G56ntkFaqOo4hde4oxlQDVFd8ZT6l/d25Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159542; c=relaxed/simple;
	bh=PpSlkR0F3X8Vt6rmL8jTosYqGbxsnJEqEqv6xOP2lgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CR0/t3xoaMg8mwr5iFVF6YSAhnrYs9TpaI/M8rGuW3ih1iyJWDFnyOXNHgFjOLC+d656f+zoAIcy38DEmzdUkmO6NeWGsMxswjMlS0vUwyGGyQhftYZQLO0cEa5j04Zr3ZWNE5D3x6AXZa8tMSG3caQ9RXnDFFxScQuBt91Vuug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3X/4k+W; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21539e1d09cso40549285ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 09:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733159540; x=1733764340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kf2aIaYh1Nx92oJkfEndZYBeiL8mic13MUY5ZrpxIqk=;
        b=S3X/4k+WvHEhA/+Si+coFKh9PX7/sGpyZ/XNrdgtOSUDifmdP2tiB+TWoVmx4tQ/Ft
         QUUzs3YAOwhxEXscbKvCRHlLmZkZufwgTB3FkOjSXZBGaztIQ5n6BXWzLHJlBiX1Algl
         SNpQDQ3+1bQIISGlgpHpSIJSkkvvocMmlpA2Rtj27+0M3Ar/LM1+UlzBASmOjtWsaZdE
         VRp2Z53AD2oP/uX3vfNSIO9m5Vd4dyZEU/Zcz+J62jia3gAniPR/la8N10lRyjyzvHRI
         JFrvcjBp4mQ1BBLUYgxR1jEBoqIQTKKF4oVvI+hY92qX9XQi4RSAkEu3QeOlxu/s4E66
         hdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733159540; x=1733764340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kf2aIaYh1Nx92oJkfEndZYBeiL8mic13MUY5ZrpxIqk=;
        b=mr1QEkokZLhyUAmKdVezeG865dWE6h9OBJm53rntcoOeI96S5hTvLdl3rk++Yj/MuA
         O3YX06A2wZEkw1PEEb8oFBEOjl9Tl+VOEr3c68zH8MuQ10sW/xqv8gxn1ZO3bcMGNE5N
         XY1OyOBjAxd61lj7lhaVUszV0GLbCTm0PSwplW6a1t9kPgsSnVO7O5JWF5bFvZEcvC0c
         juJ/JyLgkJe0ouqTFT5MiIf3Fy3uKqXJptUwgFjYLBHsJyrCXsV1XT5XjAiRMgpY1eof
         r+KsLVp7rBHcYVQr548sl7TDlVXVjnTVGrpCgcJgjgrzO8d7SwwgHV/LaiZdfttA1AGJ
         ztuA==
X-Gm-Message-State: AOJu0YwMTXJqvSE4h2IQB8KeRC6o49z1GA6Gb2/KGvzLawGqlC4k6LqF
	3PfjwgHtzgevOVEvXZtwDdxTLzHEe8nuYL2ylC2+l6ourHFFkhtmkHPAVw==
X-Gm-Gg: ASbGncu3R7QW+v4PD/NtOZGwWGX+v0Wjp8EuKDfUVHm9+lyABQ8w4+9WB7cmoofNGmj
	WrGx0NAj4XwaAUufM5w5ZgeGjnXZxYJ7fg1XIasetx/kazufyIcRwYqMlWV3qP2nELFeRPxG7UV
	COMfd+/x99fitTsNpB2ZakpWBtZpuoAx3OxrwJHIqLUWY6U7DEtolIrMIvz3FftYqTg8H/c5MYz
	5tIKXSjrsqJ6ljEhj3WhW4grjmh1wENnfjUTYSFU2pZLVKTIyPJuJHFQP72VnI=
X-Google-Smtp-Source: AGHT+IFzscsZNQkoSrwmXrFPVEvMyQuDAduXlvcv5SppmmjhmApfQoXiOrAqnnUZuIP8JIF4aa9imQ==
X-Received: by 2002:a17:902:f544:b0:215:b058:28a5 with SMTP id d9443c01a7336-215b0582cc4mr15367105ad.18.1733159539561;
        Mon, 02 Dec 2024 09:12:19 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2155338c05dsm48632295ad.199.2024.12.02.09.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 09:12:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 2 Dec 2024 09:12:17 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.13-rc1
Message-ID: <7e818c57-4952-48a3-8dd1-9ffb0672961b@roeck-us.net>
References: <CAHk-=whiWXVxhd0BATPPd6t36HJ49vApdJXZOYuAJtRA5pRi1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whiWXVxhd0BATPPd6t36HJ49vApdJXZOYuAJtRA5pRi1g@mail.gmail.com>

On Sun, Dec 01, 2024 at 02:47:21PM -0800, Linus Torvalds wrote:
> So two weeks have passed, the merge window is over, and -rc1 is pushed out.
> 

Build results:
	total: 161 pass: 155 fail: 6
Failed builds:
	csky:allmodconfig
	i386:allyesconfig
	i386:allmodconfig
	openrisc:allmodconfig
	s390:allmodconfig
	xtensa:allmodconfig
Qemu test results:
	total: 544 pass: 528 fail: 16
Failed tests:
	arm:imx25-pdk:imx_v4_v5_defconfig:nonand:mem128:net=default:imx25-pdk:initrd
	arm:imx25-pdk:imx_v4_v5_defconfig:nonand:sd:mem128:net=default:imx25-pdk:ext2
	arm:imx25-pdk:imx_v4_v5_defconfig:nonand:usb0:mem128:net=default:imx25-pdk:ext2
	arm:imx25-pdk:imx_v4_v5_defconfig:nonand:usb1:mem128:net=default:imx25-pdk:ext2
	arm:mcimx6ul-evk:imx_v6_v7_defconfig:nodrm:mem256:net=nic:net=nic:imx6ul-14x14-evk:initrd
	arm:mcimx6ul-evk:imx_v6_v7_defconfig:nodrm:sd:mem256:net=nic:net=nic:imx6ul-14x14-evk:ext2
	arm:mcimx6ul-evk:imx_v6_v7_defconfig:nodrm:usb0:mem256:net=nic:net=nic:imx6ul-14x14-evk:ext2
	arm:mcimx6ul-evk:imx_v6_v7_defconfig:nodrm:usb1:mem256:net=nic:net=nic:imx6ul-14x14-evk:ext2
	arm:mcimx7d-sabre:imx_v6_v7_defconfig:nodrm:smp2:mem256:net=nic:imx7d-sdb:initrd
	arm:mcimx7d-sabre:imx_v6_v7_defconfig:nodrm:smp2:usb1:mem256:net=nic:imx7d-sdb:ext2
	arm:mcimx7d-sabre:imx_v6_v7_defconfig:nodrm:smp2:sd:mem256:net=nic:imx7d-sdb:ext2
	arm:sabrelite:imx_v6_v7_defconfig:nodrm:mem256:net=default:imx6dl-sabrelite:initrd
	arm:sabrelite:imx_v6_v7_defconfig:nodrm:mmc,b300:mem256:net=default:imx6dl-sabrelite:ext2
	arm:sabrelite:imx_v6_v7_defconfig:nodrm:usb0:mem256:net=default:imx6dl-sabrelite:ext2
	arm:sabrelite:imx_v6_v7_defconfig:nodrm:usb1:mem256:net=default:imx6dl-sabrelite:ext2
	openrisc:or1200:or1ksim_defconfig
Unit test results:
	pass: 464016 fail: 0

There are also spurious test failures on kudo-bmc as well as various
warning backtraces. I'll list the warnings as well as the known fixes
below. The fixes are available in my fixes branch at
git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git.

Note that I did not Cc: anyone; I hope I'll get to that next week.

Guenter

---
Known fixes. Please see
git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git.
branch 'fixes' for details. All test builds pass with these fixes applied.

1eaa86ae9501 staging: gpib: Hack to fix x86 32-bit builds
34c5b4ea36f1 locking/lockdep: Enforce PROVE_RAW_LOCK_NESTING only if ARCH_SUPPORTS_RT
38fed97ad3db openrisc: place exception table at the head of vmlinux
fcbb9c518f5d staging: gpib: Make GPIB_NI_PCI_ISA depend on HAS_IOPORT
2622ab2d4ad4 timekeeping: Fix negative motion detection
aad00fb31380 ARM: imx: Re-introduce the PINCTRL selection

---
Remaining backtraces after above fixes have been applied. Unless mentioned,
the problems have been reported, but there is no fix known to me. I will
likely have missed some backtraces since there are so many.

========================================================
WARNING: possible irq lock inversion dependency detected
6.13.0-rc1-00045-ga7f3166624f6 #1 Tainted: G                 N
--------------------------------------------------------
ip/2616 just changed the state of lock:
ffffb03ce50b0d88 (napi_hash_lock){+...}-{3:3}, at: napi_disable+0x1a0/0x1b8

Seen during shutdown when the pcnet32 driver is loaded.
Caused by commit 86e25f40aa1e ("net: napi: Add napi_config").

===
WARNING: CPU: 0 PID: 0 at drivers/tty/serial/8250/8250_port.c:470 serial8250_set_defaults+0x148/0x1d8
Unsupported UART type 0

Seen with various architectures. Caused (or triggered) by commit
7c7e6c8924e7 ("tty: serial: handle HAS_IOPORT dependencies").

===
WARNING: CPU: 0 PID: 0 at include/trace/events/preemptirq.h:36 handle_int+0x11c/0x16c
RCU not watching for tracepoint

WARNING: CPU: 0 PID: 0 at include/trace/events/preemptirq.h:40 trace_hardirqs_on+0x184/0x228
RCU not watching for tracepoint

Seen with MIPS boot tests. Not analyzed.

===
WARNING: CPU: 0 PID: 0 at kernel/smp.c:807 smp_call_function_many_cond+0x4fc/0xa38
Modules linked in:
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.13.0-rc1-00045-ga7f3166624f6 #1
Hardware name: MPC8544DS e500v2 0x80210030 MPC8544 DS
...
Call Trace:
[c268fe30] [c07aee40] __SCT__lsm_static_call_capable_0+0x0/0x20 (unreliable)
[c268fe90] [24002288] 0x24002288
[c268fea0] [c002355c] flush_tlb_kernel_range+0x2c/0x50
[c268feb0] [c0024b6c] patch_mem.constprop.0+0x108/0x1b0
[c268fed0] [c00198ac] arch_static_call_transform+0x10c/0x150
[c268fef0] [c2036ba0] security_add_hooks+0x138/0x24c
[c268ff20] [c20359a4] capability_init+0x24/0x38
[c268ff30] [c2035eb4] initialize_lsm+0x48/0x90
[c268ff50] [c2036794] security_init+0x2e0/0x5b4
[c268ffa0] [c20010ec] start_kernel+0x5d4/0x81c
[c268fff0] [c0000478] set_ivor+0x150/0x18c

Seen on powerpc. This was actually introduced with 6.12. Not analyzed.

===
[    0.107470][    T0] WARNING: suspicious RCU usage
[    0.107597][    T0] 6.13.0-rc1-00045-ga7f3166624f6 #1 Not tainted
[    0.107728][    T0] -----------------------------
[    0.107803][    T0] kernel/notifier.c:586 notify_die called but RCU thinks we're quiescent!
...
[    0.115756][    T0] WARNING: suspicious RCU usage
[    0.115832][    T0] 6.13.0-rc1-00045-ga7f3166624f6 #1 Not tainted
[    0.115923][    T0] -----------------------------
[    0.115996][    T0] include/linux/rcupdate.h:850 rcu_read_lock() used illegally while idle!

and more. Seen with ppc64 boot tests. Not analyzed.

