Return-Path: <linux-kernel+bounces-274341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C909476FD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92164B22CCC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1505E14C5AF;
	Mon,  5 Aug 2024 08:13:31 +0000 (UTC)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A195A145FE2
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722845610; cv=none; b=GWYcBo3OVaX4+e5EbG+o534oyF4az7QyxIXTIUGS3xqCXmxqBTEZ2xxtyn8qFPFCooelWzn+LP/22X0ezRF55AVfLtQo/2neuDKulk1HbDIihjW97wpOkS3ZB0MPIjl1M8xm0Q+25AMaGWR0fZ6cLUxiELgsjDue77xe4In5nfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722845610; c=relaxed/simple;
	bh=DIqYBZOyLBdbL9WomYgL+UNRyuZtcxfqBW4nRrESqsQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XrPgeHRco4zoRzddfh54409+sG9ZjOw9hvxvrhoR193s2VjBn9moeAUQhbn2kor1bigIpyAOMBMGKN5HwE9bNiCu80tTZZj+AeIAnlBkiJBQMY2Xs8NohjGdgLvVg4m0jXiebS5gop58AueiAO4LrPM5BqhglW/XoXy2dI4UHNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:23c7:e51f:c68a:b0e5])
	by baptiste.telenet-ops.be with bizsmtp
	id w8DJ2C00E4yPHVg018DJN9; Mon, 05 Aug 2024 10:13:18 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sasqD-00502z-9D
	for linux-kernel@vger.kernel.org;
	Mon, 05 Aug 2024 10:13:18 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sasdY-0010I5-SJ
	for linux-kernel@vger.kernel.org;
	Mon, 05 Aug 2024 10:00:12 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v6.11-rc2
Date: Mon,  5 Aug 2024 10:00:12 +0200
Message-Id: <20240805080012.239408-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHk-=wh01xPAWUT_=J1TehFOu3SST12UTNuB=QQTeRw+1N4pDQ@mail.gmail.com>
References: <CAHk-=wh01xPAWUT_=J1TehFOu3SST12UTNuB=QQTeRw+1N4pDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Below is the list of build error/warning regressions/improvements in
v6.11-rc2[1] compared to v6.10[2].

Summarized:
  - build errors: +9/-20
  - build warnings: +2/-19

JFYI, when comparing v6.11-rc2[1] to v6.11-rc1[3], the summaries are:
  - build errors: +9/-4
  - build warnings: +0/-2

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed/ (all 132 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/0c3836482481200ead7b416ca80c68a29cfdaabd/ (all 132 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/8400291e289ee6b2bf9779ff1c83a291501f017b/ (all 132 configs)


*** ERRORS ***

9 error regressions:
  + /kisskb/src/arch/mips/sgi-ip22/ip22-gio.c: error: initialization of 'int (*)(struct device *, const struct device_driver *)' from incompatible pointer type 'int (*)(struct device *, struct device_driver *)' [-Werror=incompatible-pointer-types]:  => 384:14
  + /kisskb/src/drivers/md/dm-integrity.c: error: logical not is only applied to the left hand side of comparison [-Werror=logical-not-parentheses]:  => 4718:45
  + /kisskb/src/fs/bcachefs/data_update.c: error: the frame size of 1032 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]:  => 338:1
  + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_950' declared with attribute error: FIELD_GET: mask is not constant:  => 510:38
  + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_951' declared with attribute error: FIELD_GET: mask is not constant:  => 510:38
  + /kisskb/src/kernel/fork.c: error: #warning clone3() entry point is missing, please fix [-Werror=cpp]:  => 3072:2
  + {standard input}: Error: displacement to undefined symbol .L142 overflows 8-bit field :  => 1070
  + {standard input}: Error: displacement to undefined symbol .L161 overflows 8-bit field :  => 1075
  + {standard input}: Error: unknown pseudo-op: `.l18':  => 1111

20 error improvements:
  - /kisskb/src/arch/sparc/include/asm/floppy_64.h: error: no previous prototype for 'sparc_floppy_irq' [-Werror=missing-prototypes]: 200:13 => 
  - /kisskb/src/arch/sparc/include/asm/floppy_64.h: error: no previous prototype for 'sun_pci_fd_dma_callback' [-Werror=missing-prototypes]: 437:6 => 
  - /kisskb/src/arch/sparc/power/hibernate.c: error: no previous prototype for 'pfn_is_nosave' [-Werror=missing-prototypes]: 22:5 => 
  - /kisskb/src/arch/sparc/power/hibernate.c: error: no previous prototype for 'restore_processor_state' [-Werror=missing-prototypes]: 35:6 => 
  - /kisskb/src/arch/sparc/power/hibernate.c: error: no previous prototype for 'save_processor_state' [-Werror=missing-prototypes]: 30:6 => 
  - /kisskb/src/arch/sparc/prom/misc_64.c: error: no previous prototype for 'prom_get_mmu_ihandle' [-Werror=missing-prototypes]: 165:5 => 
  - /kisskb/src/arch/sparc/prom/p1275.c: error: no previous prototype for 'prom_cif_init' [-Werror=missing-prototypes]: 52:6 => 
  - /kisskb/src/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c: error: unknown option after '#pragma GCC diagnostic' kind [-Werror=pragmas]: 16:9 => 
  - /kisskb/src/drivers/gpu/drm/msm/adreno/adreno_gen7_0_0_snapshot.h: error: 'gen7_0_0_external_core_regs' defined but not used [-Werror=unused-variable]: 924:19 => 
  - /kisskb/src/drivers/gpu/drm/msm/adreno/adreno_gen7_2_0_snapshot.h: error: 'gen7_2_0_external_core_regs' defined but not used [-Werror=unused-variable]: 748:19 => 
  - /kisskb/src/drivers/gpu/drm/msm/adreno/adreno_gen7_9_0_snapshot.h: error: 'gen7_9_0_external_core_regs' defined but not used [-Werror=unused-variable]: 1438:19 => 
  - /kisskb/src/drivers/gpu/drm/msm/adreno/adreno_gen7_9_0_snapshot.h: error: 'gen7_9_0_sptp_clusters' defined but not used [-Werror=unused-variable]: 1188:43 => 
  - /kisskb/src/fs/bcachefs/data_update.c: error: the frame size of 1028 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]: 338:1 => 
  - error: arch/sparc/kernel/process_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text': (.fixup+0x4), (.fixup+0xc) => 
  - error: arch/sparc/kernel/signal_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text': (.fixup+0x18), (.fixup+0x10), (.fixup+0x8), (.fixup+0x20), (.fixup+0x0) => 
  - error: relocation truncated to fit: R_SPARC_WDISP22 against `.init.text': (.head.text+0x5100), (.head.text+0x5040) => 
  - error: relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o: (.init.text+0xa4) => 
  - {standard input}: Error: displacement to undefined symbol .L137 overflows 8-bit field : 1031, 1105 => 
  - {standard input}: Error: displacement to undefined symbol .L158 overflows 8-bit field : 1110 => 
  - {standard input}: Error: pcrel too far: 1074, 1020, 1126, 1254, 1021, 1095, 1022, 1096, 1255 => 1255, 1254, 1059, 1061, 1060


*** WARNINGS ***

2 warning regressions:
  + /kisskb/src/fs/btrfs/fiemap.c: warning: 'last_extent_end' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 822:19
  + /kisskb/src/kernel/fork.c: warning: #warning clone3() entry point is missing, please fix [-Wcpp]:  => 3072:2

19 warning improvements:
  - ./.config.32r1_defconfig: warning: override: CPU_BIG_ENDIAN changes choice state: 93 => 
  - ./.config.32r2_defconfig: warning: override: CPU_BIG_ENDIAN changes choice state: 93 => 
  - ./.config.32r6_defconfig: warning: override: CPU_BIG_ENDIAN changes choice state: 95 => 
  - ./.config.64r1_defconfig: warning: override: CPU_BIG_ENDIAN changes choice state: 96 => 
  - ./.config.64r2_defconfig: warning: override: CPU_BIG_ENDIAN changes choice state: 96 => 
  - ./.config.64r6_defconfig: warning: override: CPU_BIG_ENDIAN changes choice state: 98 => 
  - ./.config.micro32r2_defconfig: warning: override: CPU_BIG_ENDIAN changes choice state: 94 => 
  - .config: warning: override: ARCH_RV32I changes choice state: 6414 => 
  - .config: warning: override: CPU_BIG_ENDIAN changes choice state: 92, 94, 95, 97, 93 => 
  - /kisskb/src/arch/mips/sgi-ip22/ip22-berr.c: warning: no previous prototype for 'ip22_be_init' [-Wmissing-prototypes]: 113:13 => 
  - /kisskb/src/arch/mips/sgi-ip22/ip22-berr.c: warning: no previous prototype for 'ip22_be_interrupt' [-Wmissing-prototypes]: 89:6 => 
  - /kisskb/src/arch/mips/sgi-ip22/ip22-gio.c: warning: no previous prototype for 'ip22_gio_init' [-Wmissing-prototypes]: 398:12 => 
  - /kisskb/src/arch/mips/sgi-ip22/ip22-gio.c: warning: no previous prototype for 'ip22_gio_set_64bit' [-Wmissing-prototypes]: 249:6 => 
  - /kisskb/src/arch/mips/sgi-ip22/ip22-time.c: warning: no previous prototype for 'indy_8254timer_irq' [-Wmissing-prototypes]: 119:18 => 
  - /kisskb/src/arch/sparc/prom/misc_64.c: warning: no previous prototype for 'prom_get_mmu_ihandle' [-Wmissing-prototypes]: 165:5 => 
  - /kisskb/src/arch/sparc/prom/p1275.c: warning: no previous prototype for 'prom_cif_init' [-Wmissing-prototypes]: 52:6 => 
  - /kisskb/src/drivers/base/regmap/regcache-maple.c: warning: 'lower_index' is used uninitialized [-Wuninitialized]: 113:23 => 
  - /kisskb/src/drivers/base/regmap/regcache-maple.c: warning: 'lower_last' is used uninitialized [-Wuninitialized]: 113:36 => 
  - /kisskb/src/fs/btrfs/extent_io.c: warning: 'last_extent_end' may be used uninitialized in this function [-Wmaybe-uninitialized]: 3285:19 => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

