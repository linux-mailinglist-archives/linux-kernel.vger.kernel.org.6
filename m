Return-Path: <linux-kernel+bounces-320757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74087970FDB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F8D1C20404
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 07:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FF81B29C8;
	Mon,  9 Sep 2024 07:29:23 +0000 (UTC)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B151B2526
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 07:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866963; cv=none; b=MwJNmllX9tkvbfnQe6grnZRTSYhQHhg5qvsfTvwgxsopIQ9N/siahbsBQ8C2CfuYtK0eM6NoIKOqHrDyKLEB6BlOd3pBvF3OksSQSrTZq8fr7I2gIffWEXV2tBgkcQP4GLPjTsKekpQAOFD+izhR839ABPdhDeR8SS6+skGf/l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866963; c=relaxed/simple;
	bh=M13exsH7D4IPUjTesVG8xkhW5fD5Ru0FvvkHHQdmAoc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LoIztx9++sIWG7yBFQLQ3CL7vmRGxFd8Km2hUmPjJswnjKO+rhTvaTzwU/i6fIqaBY4Yrd5Yb7333dKKLW6mEP04f18Tsgmxd2UL3K9Z8bqbiBWLAh6ZkJAbnjOJlF8g2w0I4w/G93KN9TGnjUSErg7XYBx252cgchaWAXVh9+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:9ac7:69d6:248e:ed83])
	by baptiste.telenet-ops.be with cmsmtp
	id A7VB2D00352UNxy017VBxH; Mon, 09 Sep 2024 09:29:11 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1snYpg-002Zhn-5F
	for linux-kernel@vger.kernel.org;
	Mon, 09 Sep 2024 09:29:10 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1snYpi-007Khw-Sd
	for linux-kernel@vger.kernel.org;
	Mon, 09 Sep 2024 09:29:10 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v6.11-rc7
Date: Mon,  9 Sep 2024 09:29:10 +0200
Message-Id: <20240909072910.1747880-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHk-=whHwbceFq8XCK2uLCK9_aGywqmgMq3Udp5OJwFvLixpEA@mail.gmail.com>
References: <CAHk-=whHwbceFq8XCK2uLCK9_aGywqmgMq3Udp5OJwFvLixpEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Below is the list of build error/warning regressions/improvements in
v6.11-rc7[1] compared to v6.10[2].

Summarized:
  - build errors: +5/-21
  - build warnings: +1/-53

JFYI, when comparing v6.11-rc7[1] to v6.11-rc6[3], the summaries are:
  - build errors: +0/-2
  - build warnings: +0/-34

Note that there may be false regressions, as some logs are incomplete.
Still, they're build errors/warnings.

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/da3ea35007d0af457a0afc87e84fddaebc4e0b63/ (129 out of 132 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/0c3836482481200ead7b416ca80c68a29cfdaabd/ (all 132 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/431c1646e1f86b949fa3685efc50b660a364c2b6/ (131 out of 132 configs)


*** ERRORS ***

5 error regressions:
  + /kisskb/src/drivers/md/dm-integrity.c: error: logical not is only applied to the left hand side of comparison [-Werror=logical-not-parentheses]:  => 4718:45
  + /kisskb/src/kernel/fork.c: error: #warning clone3() entry point is missing, please fix [-Werror=cpp]:  => 3072:2
  + {standard input}: Error: displacement to undefined symbol .L142 overflows 8-bit field :  => 1070
  + {standard input}: Error: displacement to undefined symbol .L161 overflows 8-bit field :  => 1075
  + {standard input}: Error: unknown pseudo-op: `.l18':  => 1111

21 error improvements:
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
  - error: arch/sparc/kernel/signal_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text': (.fixup+0x18), (.fixup+0x10), (.fixup+0x8), (.fixup+0x0), (.fixup+0x20) => 
  - error: relocation truncated to fit: R_SPARC_WDISP22 against `.init.text': (.head.text+0x5040), (.head.text+0x5100) => 
  - error: relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o: (.init.text+0xa4) => 
  - {standard input}: Error: displacement to undefined symbol .L137 overflows 8-bit field : 1105, 1031 => 
  - {standard input}: Error: displacement to undefined symbol .L158 overflows 8-bit field : 1110 => 
  - {standard input}: Error: pcrel too far: 1020, 1254, 1021, 1095, 1074, 1255, 1096, 1022, 1126 => 1397, 1060, 1059, 1061
  - {standard input}: Error: unknown pseudo-op: `.al': 1270 => 


*** WARNINGS ***

1 warning regressions:
  + /kisskb/src/kernel/fork.c: warning: #warning clone3() entry point is missing, please fix [-Wcpp]:  => 3072:2

53 warning improvements:
  - ./.config.32r1_defconfig: warning: override: CPU_BIG_ENDIAN changes choice state: 93 => 
  - ./.config.32r2_defconfig: warning: override: CPU_BIG_ENDIAN changes choice state: 93 => 
  - ./.config.32r6_defconfig: warning: override: CPU_BIG_ENDIAN changes choice state: 95 => 
  - ./.config.64r1_defconfig: warning: override: CPU_BIG_ENDIAN changes choice state: 96 => 
  - ./.config.64r2_defconfig: warning: override: CPU_BIG_ENDIAN changes choice state: 96 => 
  - ./.config.64r6_defconfig: warning: override: CPU_BIG_ENDIAN changes choice state: 98 => 
  - ./.config.micro32r2_defconfig: warning: override: CPU_BIG_ENDIAN changes choice state: 94 => 
  - .config: warning: override: ARCH_RV32I changes choice state: 6414 => 
  - .config: warning: override: CPU_BIG_ENDIAN changes choice state: 94, 95, 93, 92, 97 => 
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
  - modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0x110 (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0x14 (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0x30 (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0x4c (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0x68 (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0x84 (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0xa0 (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0xbc (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0xd8 (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0xf4 (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps+0x14 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps+0x30 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps+0x4c (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps+0x68 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps+0x84 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps+0xa0 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps+0xbc (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps+0xd8 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps+0x14 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps+0x30 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps+0x4c (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps+0x68 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps+0x84 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps+0xa0 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps+0xbc (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps+0x14 (section: .data) -> qede_forced_speed_100000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps+0x30 (section: .data) -> qede_forced_speed_100000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps+0x4c (section: .data) -> qede_forced_speed_100000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps+0x68 (section: .data) -> qede_forced_speed_100000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps+0x84 (section: .data) -> qede_forced_speed_100000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps+0xa0 (section: .data) -> qede_forced_speed_100000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps+0xbc (section: .data) -> qede_forced_speed_100000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: lib/test_bitmap: section mismatch in reference: find_next_bit+0x40 (section: .text.unlikely) -> test_print (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: vmlinux: section mismatch in reference: __trace_event_discard_commit+0x184 (section: .text.unlikely) -> initcall_level_names (section: .init.data): N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

