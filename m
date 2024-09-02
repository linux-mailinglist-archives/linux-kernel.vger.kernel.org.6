Return-Path: <linux-kernel+bounces-311589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BA2968AC9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4462F1F22AD4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F9119C563;
	Mon,  2 Sep 2024 15:20:44 +0000 (UTC)
Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [195.130.132.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4CA1CB50B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 15:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725290444; cv=none; b=Trkgfu5OI+BC41Fu+ezp2T8bFPyMTrj0bCvsd49N7Ra8Qtkh2Yhb9H25NOCmz64NQ5ui63cuF8ZKK+1OItaeN6eYv6+oaq3KzWUe0vBdgQRDnXaUTUpO3IrX+TiaX/00ez46UZwFU1DDvp768gLWFY6eVZOuoBSDb3PXxzkh6/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725290444; c=relaxed/simple;
	bh=WtpfqRJCDIJX9EmaEYcONcuiy9zTzHzsUViT4SMi7cA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DnE5qvcdrNyugsg14QS/VkZV6eytyUBjVMk/g0snVJdM8hTU2Api4/yoSwMGV6RNygtvi1qcug1UW9YM43U3eYp6+pMcv/r6cOyrfm0kKIa0zfgNGYbEcCeKOD8q9WdRBTIOrflsqiM9z4yCvTqgHzmFLbx8C6JYdrJkqKqANtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
	by cantor.telenet-ops.be (Postfix) with ESMTPS id 4WyBzD4Cqlz4x2ym
	for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 17:11:04 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:2f79:eac0:e12c:6c11])
	by andre.telenet-ops.be with cmsmtp
	id 7TAx2D0070Z5ZN201TAx6X; Mon, 02 Sep 2024 17:10:57 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sl8hi-001qCz-I6
	for linux-kernel@vger.kernel.org;
	Mon, 02 Sep 2024 17:10:57 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sl8hl-001bCH-7j
	for linux-kernel@vger.kernel.org;
	Mon, 02 Sep 2024 17:10:57 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v6.11-rc6
Date: Mon,  2 Sep 2024 17:10:57 +0200
Message-Id: <20240902151057.381306-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHk-=wgumCUwjVkGREh1WwZ2ia5EqSjAQ_4wjUDw3-m0aT7KFA@mail.gmail.com>
References: <CAHk-=wgumCUwjVkGREh1WwZ2ia5EqSjAQ_4wjUDw3-m0aT7KFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Below is the list of build error/warning regressions/improvements in
v6.11-rc6[1] compared to v6.10[2].

Summarized:
  - build errors: +5/-20
  - build warnings: +1/-19

JFYI, when comparing v6.11-rc6[1] to v6.11-rc5[3], the summaries are:
  - build errors: +2/-0
  - build warnings: +0/-1

Note that there may be false regressions, as some logs are incomplete.
Still, they're build errors/warnings.

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/431c1646e1f86b949fa3685efc50b660a364c2b6/ (131 out of 132 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/0c3836482481200ead7b416ca80c68a29cfdaabd/ (all 132 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/5be63fc19fcaa4c236b307420483578a56986a37/ (131 out of 132 configs)


*** ERRORS ***

5 error regressions:
  + /kisskb/src/drivers/md/dm-integrity.c: error: logical not is only applied to the left hand side of comparison [-Werror=logical-not-parentheses]:  => 4718:45
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
  - error: arch/sparc/kernel/process_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text': (.fixup+0xc), (.fixup+0x4) => 
  - error: arch/sparc/kernel/signal_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text': (.fixup+0x0), (.fixup+0x20), (.fixup+0x10), (.fixup+0x8), (.fixup+0x18) => 
  - error: relocation truncated to fit: R_SPARC_WDISP22 against `.init.text': (.head.text+0x5100), (.head.text+0x5040) => 
  - error: relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o: (.init.text+0xa4) => 
  - {standard input}: Error: displacement to undefined symbol .L137 overflows 8-bit field : 1031, 1105 => 
  - {standard input}: Error: displacement to undefined symbol .L158 overflows 8-bit field : 1110 => 
  - {standard input}: Error: pcrel too far: 1096, 1022, 1021, 1254, 1074, 1095, 1020, 1255, 1126 => 1060, 1061, 1255, 1254, 1059


*** WARNINGS ***

1 warning regressions:
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
  - .config: warning: override: CPU_BIG_ENDIAN changes choice state: 94, 93, 92, 95, 97 => 
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

