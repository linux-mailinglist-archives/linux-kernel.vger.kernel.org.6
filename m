Return-Path: <linux-kernel+bounces-170405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FFE8BD660
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 22:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DAC1283166
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 20:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7061156B76;
	Mon,  6 May 2024 20:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtQKPsSz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6476215D5CC
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715028032; cv=none; b=WSu8jVx4IGUGP6h8yJKXvIVE2FytQ6hxzKZG4MoyY0oQP1dyqg6AdJGGFH+tW+PsJyTum5pvkFkN1YhUQSjhd1Omfs+1xYgCyxQgXpNtTas/A1WuEfkVXx+dU2KjhAoI9vmR0+16GseKGjVvo5ELBYQxB3vEn5Hvl9H+CtxUa08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715028032; c=relaxed/simple;
	bh=17mRCbCfXGe86VG0NVuPEUfPhy17zEjuU8/1HmxjZxk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=NCCicSNsM+b0Sf//EfK2Er/aYmDb054+NA+OVY807enfoV61eNF0OtMzBRLdFdH1+Epi9MLOQjhxoZxQlslaRh8Q9DdoMCm1ytafn9jGaiBXWebT4y8f2pNIa9Fcss+B9YMq+n8nu5SHQ+LTu5dF5Uo7Q+PEEiW5klOKalraEj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtQKPsSz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9306DC116B1;
	Mon,  6 May 2024 20:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715028031;
	bh=17mRCbCfXGe86VG0NVuPEUfPhy17zEjuU8/1HmxjZxk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=QtQKPsSzuNs6uzyWsroCoJ4KrnIGRPNK8LfMhdoYMB8cGQHSloKsVexyMci4+IAfE
	 F+Ean8pzVvYi5B9A4m4Z/zDiiLyCg74+C/udlm5hbEcL+xeMuoN7Wcg8WBeMU5iDGX
	 3MYLPI4JFro/Fd8vY7osVlcqI2+V22lxRD/USee+uFSR/7SQ/dmDkieWvWW2UrNuU7
	 vLnSfECXxxS334Uygg47qobO4pcwoxW9rs55KHaWBj9hI3ywhUYfXKeCVjIV+vOFTD
	 xB6M8vflhZnHPzjP2c0UX7FT/z6jP+MqLJ4lrWwPvKTZa1dTSagmuoXtn8Ud8IyqaD
	 6NCz1zIzG97MQ==
Date: Mon, 06 May 2024 15:40:29 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 christophe.leroy@csgroup.eu
In-Reply-To: <20240506125152.78174-1-mpe@ellerman.id.au>
References: <20240506125152.78174-1-mpe@ellerman.id.au>
Message-Id: <171502764539.89665.4515475844355212839.robh@kernel.org>
Subject: Re: [PATCH 0/7] Remove 40x


On Mon, 06 May 2024 22:51:45 +1000, Michael Ellerman wrote:
> The 40x platforms & CPUs are old and have been unmaintained for years, and as
> far as we can tell have no users.
> 
> Note 44x and 476 are not affected.
> 
> Christophe first proposed removing 40x in 2020:
>   https://lore.kernel.org/linuxppc-dev/40899eb1b8f10da3706acd06c3d46d2418c8886e.1585635837.git.christophe.leroy@c-s.fr/
> 
> And on a few subsequent occasions.
> 
> The proposed removal was covered on Phronix:
>   https://www.phoronix.com/news/PowerPC-40x-400-Linux-Removal
> 
> OpenWRT dropped support in 2019.
> 
> So unless anyone steps up to maintain it, remove 40x as unused. RIP.
> 
> cheers
> 
> 
> More context: https://github.com/linuxppc/issues/issues/349
> 
> Christophe Leroy (4):
>   powerpc/40x: Remove 40x platforms.
>   powerpc/boot: Remove all 40x platforms from boot
>   powerpc: Remove core support for 40x
>   powerpc/platforms: Move files from 4xx to 44x
> 
> Michael Ellerman (3):
>   powerpc: Remove 40x from Kconfig and defconfig
>   powerpc/4xx: Remove CONFIG_BOOKE_OR_40x
>   powerpc: Replace CONFIG_4xx with CONFIG_44x
> 
>  MAINTAINERS                                   |   1 -
>  arch/powerpc/Kconfig                          |  17 +-
>  arch/powerpc/Kconfig.debug                    |  13 -
>  arch/powerpc/Makefile                         |   5 -
>  arch/powerpc/boot/4xx.c                       | 266 -------
>  arch/powerpc/boot/4xx.h                       |   4 -
>  arch/powerpc/boot/Makefile                    |  11 -
>  arch/powerpc/boot/cuboot-acadia.c             | 171 -----
>  arch/powerpc/boot/cuboot-hotfoot.c            | 139 ----
>  arch/powerpc/boot/cuboot-kilauea.c            |  46 --
>  arch/powerpc/boot/dcr.h                       |  11 -
>  arch/powerpc/boot/dts/acadia.dts              | 224 ------
>  arch/powerpc/boot/dts/hotfoot.dts             | 296 -------
>  arch/powerpc/boot/dts/kilauea.dts             | 407 ----------
>  arch/powerpc/boot/dts/obs600.dts              | 314 --------
>  arch/powerpc/boot/ppcboot-hotfoot.h           | 119 ---
>  arch/powerpc/boot/ppcboot.h                   |   2 +-
>  arch/powerpc/configs/40x.config               |   2 -
>  arch/powerpc/configs/40x/acadia_defconfig     |  61 --
>  arch/powerpc/configs/40x/kilauea_defconfig    |  69 --
>  arch/powerpc/configs/40x/klondike_defconfig   |  43 --
>  arch/powerpc/configs/40x/makalu_defconfig     |  59 --
>  arch/powerpc/configs/40x/obs600_defconfig     |  69 --
>  arch/powerpc/configs/40x/walnut_defconfig     |  55 --
>  arch/powerpc/configs/ppc40x_defconfig         |  74 --
>  arch/powerpc/include/asm/cacheflush.h         |   2 +-
>  arch/powerpc/include/asm/cputable.h           |   7 -
>  arch/powerpc/include/asm/hw_irq.h             |   8 +-
>  arch/powerpc/include/asm/irq.h                |   2 +-
>  arch/powerpc/include/asm/kup.h                |   2 +-
>  arch/powerpc/include/asm/mmu.h                |   7 -
>  arch/powerpc/include/asm/nohash/32/mmu-40x.h  |  68 --
>  arch/powerpc/include/asm/nohash/32/pgtable.h  |   4 +-
>  arch/powerpc/include/asm/nohash/32/pte-40x.h  |  73 --
>  arch/powerpc/include/asm/nohash/mmu.h         |   5 +-
>  arch/powerpc/include/asm/ppc_asm.h            |   2 +-
>  arch/powerpc/include/asm/processor.h          |   2 +-
>  arch/powerpc/include/asm/ptrace.h             |   2 +-
>  arch/powerpc/include/asm/reg.h                |  27 +-
>  arch/powerpc/include/asm/reg_booke.h          | 113 +--
>  arch/powerpc/include/asm/time.h               |   7 +-
>  arch/powerpc/include/asm/udbg.h               |   1 -
>  arch/powerpc/kernel/Makefile                  |   1 -
>  arch/powerpc/kernel/asm-offsets.c             |   2 +-
>  arch/powerpc/kernel/cpu_specs.h               |   4 -
>  arch/powerpc/kernel/cpu_specs_40x.h           | 280 -------
>  arch/powerpc/kernel/entry_32.S                |  48 +-
>  arch/powerpc/kernel/epapr_hcalls.S            |   2 +-
>  arch/powerpc/kernel/head_32.h                 |  12 +-
>  arch/powerpc/kernel/head_40x.S                | 721 ------------------
>  arch/powerpc/kernel/head_booke.h              |   3 +-
>  arch/powerpc/kernel/irq.c                     |   2 +-
>  arch/powerpc/kernel/kgdb.c                    |   4 +-
>  arch/powerpc/kernel/misc_32.S                 |  40 -
>  arch/powerpc/kernel/process.c                 |   4 +-
>  arch/powerpc/kernel/setup.h                   |   2 +-
>  arch/powerpc/kernel/setup_32.c                |   2 +-
>  arch/powerpc/kernel/time.c                    |   2 +-
>  arch/powerpc/kernel/traps.c                   |   2 +-
>  arch/powerpc/kernel/udbg.c                    |   3 -
>  arch/powerpc/kernel/udbg_16550.c              |  23 -
>  arch/powerpc/mm/fault.c                       |   4 +-
>  arch/powerpc/mm/mmu_context.c                 |   2 +-
>  arch/powerpc/mm/mmu_decl.h                    |   8 +-
>  arch/powerpc/mm/nohash/40x.c                  | 161 ----
>  arch/powerpc/mm/nohash/Makefile               |   1 -
>  arch/powerpc/mm/nohash/kup.c                  |   2 -
>  arch/powerpc/mm/nohash/mmu_context.c          |   5 +-
>  arch/powerpc/mm/nohash/tlb_low.S              |  27 +-
>  arch/powerpc/mm/ptdump/Makefile               |   2 +-
>  arch/powerpc/platforms/40x/Kconfig            |  78 --
>  arch/powerpc/platforms/40x/Makefile           |   2 -
>  arch/powerpc/platforms/40x/ppc40x_simple.c    |  74 --
>  arch/powerpc/platforms/44x/Makefile           |   6 +-
>  arch/powerpc/platforms/{4xx => 44x}/cpm.c     |   0
>  arch/powerpc/platforms/{4xx => 44x}/gpio.c    |   0
>  .../powerpc/platforms/{4xx => 44x}/hsta_msi.c |   0
>  arch/powerpc/platforms/44x/machine_check.c    |  15 +
>  arch/powerpc/platforms/{4xx => 44x}/pci.c     | 100 ---
>  arch/powerpc/platforms/{4xx => 44x}/pci.h     |   0
>  arch/powerpc/platforms/{4xx => 44x}/soc.c     |   0
>  arch/powerpc/platforms/{4xx => 44x}/uic.c     |   0
>  arch/powerpc/platforms/4xx/Makefile           |   7 -
>  arch/powerpc/platforms/4xx/machine_check.c    |  23 -
>  arch/powerpc/platforms/Kconfig                |   1 -
>  arch/powerpc/platforms/Kconfig.cputype        |  30 +-
>  arch/powerpc/platforms/Makefile               |   2 -
>  arch/powerpc/sysdev/Kconfig                   |   4 +-
>  scripts/head-object-list.txt                  |   1 -
>  89 files changed, 77 insertions(+), 4445 deletions(-)
>  delete mode 100644 arch/powerpc/boot/cuboot-acadia.c
>  delete mode 100644 arch/powerpc/boot/cuboot-hotfoot.c
>  delete mode 100644 arch/powerpc/boot/cuboot-kilauea.c
>  delete mode 100644 arch/powerpc/boot/dts/acadia.dts
>  delete mode 100644 arch/powerpc/boot/dts/hotfoot.dts
>  delete mode 100644 arch/powerpc/boot/dts/kilauea.dts
>  delete mode 100644 arch/powerpc/boot/dts/obs600.dts
>  delete mode 100644 arch/powerpc/boot/ppcboot-hotfoot.h
>  delete mode 100644 arch/powerpc/configs/40x.config
>  delete mode 100644 arch/powerpc/configs/40x/acadia_defconfig
>  delete mode 100644 arch/powerpc/configs/40x/kilauea_defconfig
>  delete mode 100644 arch/powerpc/configs/40x/klondike_defconfig
>  delete mode 100644 arch/powerpc/configs/40x/makalu_defconfig
>  delete mode 100644 arch/powerpc/configs/40x/obs600_defconfig
>  delete mode 100644 arch/powerpc/configs/40x/walnut_defconfig
>  delete mode 100644 arch/powerpc/configs/ppc40x_defconfig
>  delete mode 100644 arch/powerpc/include/asm/nohash/32/mmu-40x.h
>  delete mode 100644 arch/powerpc/include/asm/nohash/32/pte-40x.h
>  delete mode 100644 arch/powerpc/kernel/cpu_specs_40x.h
>  delete mode 100644 arch/powerpc/kernel/head_40x.S
>  delete mode 100644 arch/powerpc/mm/nohash/40x.c
>  delete mode 100644 arch/powerpc/platforms/40x/Kconfig
>  delete mode 100644 arch/powerpc/platforms/40x/Makefile
>  delete mode 100644 arch/powerpc/platforms/40x/ppc40x_simple.c
>  rename arch/powerpc/platforms/{4xx => 44x}/cpm.c (100%)
>  rename arch/powerpc/platforms/{4xx => 44x}/gpio.c (100%)
>  rename arch/powerpc/platforms/{4xx => 44x}/hsta_msi.c (100%)
>  rename arch/powerpc/platforms/{4xx => 44x}/pci.c (95%)
>  rename arch/powerpc/platforms/{4xx => 44x}/pci.h (100%)
>  rename arch/powerpc/platforms/{4xx => 44x}/soc.c (100%)
>  rename arch/powerpc/platforms/{4xx => 44x}/uic.c (100%)
>  delete mode 100644 arch/powerpc/platforms/4xx/Makefile
>  delete mode 100644 arch/powerpc/platforms/4xx/machine_check.c
> 
> --
> 2.45.0
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y acadia.dtb hotfoot.dtb kilauea.dtb obs600.dtb' for 20240506125152.78174-1-mpe@ellerman.id.au:

make[2]: *** No rule to make target 'arch/powerpc/boot/dts/obs600.dtb'.
make[2]: *** No rule to make target 'arch/powerpc/boot/dts/hotfoot.dtb'.
make[2]: *** No rule to make target 'arch/powerpc/boot/dts/kilauea.dtb'.
make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1392: hotfoot.dtb] Error 2
make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1392: kilauea.dtb] Error 2
make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1392: obs600.dtb] Error 2
make[2]: *** No rule to make target 'arch/powerpc/boot/dts/acadia.dtb'.
make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1392: acadia.dtb] Error 2
make: *** [Makefile:240: __sub-make] Error 2
make: Target 'acadia.dtb' not remade because of errors.
make: Target 'hotfoot.dtb' not remade because of errors.
make: Target 'kilauea.dtb' not remade because of errors.
make: Target 'obs600.dtb' not remade because of errors.






