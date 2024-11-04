Return-Path: <linux-kernel+bounces-394703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A94C9BB304
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E39D1C20834
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D33D1D4324;
	Mon,  4 Nov 2024 11:11:40 +0000 (UTC)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6115E1AF0AD
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 11:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730718700; cv=none; b=GgyqD/M/vgCxv8ZUVMcB25oztVoYBGZj6BX5Nompv3+BsEYQT0NjC6HQtwb89uKASumcbT0tk3WoYFqH65lfGVrCo99YOnY/vEDEq/fPTUdsBVRQxktC5jUjyjfRpY2dsJgwGn3L3xZa4AW6BGITjMSGOLOJavMfsii9TTGgk0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730718700; c=relaxed/simple;
	bh=VhoUkpsHTJztdL+oXJxlBixKh5kjVJmfAaHE1uMRi4g=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o5ybK1eBKPwpB40fPRyaW8M5Vsqc/aRNUr70sKK055pPLgCnisUm8+vPT1/Z5ajw5AsYlyzNEV6Y3eU6LtFrZsO+CY0TvfW4rGN3ht+Xly8vu87nJ99EdXasEUdkR4iyjAa97ekaSgL/Pu8uuno00WR3l5ecmP0nHvmYytd+lT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:cff2:a4e4:667a:351c])
	by andre.telenet-ops.be with cmsmtp
	id YbBU2D00E2b9NYg01bBUsL; Mon, 04 Nov 2024 12:11:28 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1t7uzB-006FZD-0R
	for linux-kernel@vger.kernel.org;
	Mon, 04 Nov 2024 12:11:24 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1t7uzU-00E1cG-LX
	for linux-kernel@vger.kernel.org;
	Mon, 04 Nov 2024 12:11:24 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v6.12-rc6
Date: Mon,  4 Nov 2024 12:11:24 +0100
Message-Id: <20241104111124.3342797-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHk-=whORbp07SkmAUbXTRtjk7imEgWXReGMaeteMg-gAFU_cA@mail.gmail.com>
References: <CAHk-=whORbp07SkmAUbXTRtjk7imEgWXReGMaeteMg-gAFU_cA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Below is the list of build error/warning regressions/improvements in
v6.12-rc6[1] compared to v6.11[2].

Summarized:
  - build errors: +3/-7
  - build warnings: +32/-3

JFYI, when comparing v6.12-rc6[1] to v6.12-rc5[3], the summaries are:
  - build errors: +0/-4
  - build warnings: +0/-1

Note that there may be false regressions, as some logs are incomplete.
Still, they're build errors/warnings.

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/59b723cd2adbac2a34fc8e12c74ae26ae45bf230/ (all 194 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/98f7e32f20d28ec452afb208f9cffc08448a2652/ (131 out of 194 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/81983758430957d9a5cb3333fe324fd70cf63e7e/ (all 194 configs)


*** ERRORS ***

3 error regressions:
  + /kisskb/src/crypto/async_tx/async_tx.c: error: no previous prototype for '__async_tx_find_channel' [-Werror=missing-prototypes]:  => 43:1
  + /kisskb/src/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t {aka long long unsigned int}' [-Werror=format=]:  => 126:37
  + /kisskb/src/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Werror=format=]:  => 126:46

7 error improvements:
  - /kisskb/src/drivers/md/dm-integrity.c: error: logical not is only applied to the left hand side of comparison [-Werror=logical-not-parentheses]: 4720:45 => 
  - /kisskb/src/drivers/media/platform/nxp/imx-pxp.h: error: initializer element is not constant: 582:38 => 
  - {standard input}: Error: displacement to undefined symbol .L142 overflows 8-bit field : 1070 => 
  - {standard input}: Error: displacement to undefined symbol .L161 overflows 8-bit field : 1075 => 
  - {standard input}: Error: pcrel too far: 1061, 1060, 1059 => 1397
  - {standard input}: Error: unknown pseudo-op: `.l18': 1111 => 
  - {standard input}: Error: unknown pseudo-op: `.siz': 1273 => 


*** WARNINGS ***

32 warning regressions:
  + .config: warning: override: reassigning to symbol MIPS_CPS_NS16550_SHIFT: 15210, 15216 => 15350, 15342, 15344
  + .config: warning: override: reassigning to symbol UML_NET_MCAST:  => 14881, 15124
  + /kisskb/src/arch/mips/cavium-octeon/executive/cvmx-helper-errata.c: warning: no previous prototype for '__cvmx_helper_errata_qlm_disable_2nd_order_cdr' [-Wmissing-prototypes]:  => 49:6
  + /kisskb/src/arch/mips/cavium-octeon/executive/cvmx-interrupt-decodes.c: warning: no previous prototype for '__cvmx_interrupt_gmxx_rxx_int_en_enable' [-Wmissing-prototypes]:  => 53:6
  + /kisskb/src/arch/mips/cavium-octeon/octeon-platform.c: warning: no previous prototype for 'octeon_fill_mac_addresses' [-Wmissing-prototypes]:  => 701:13
  + /kisskb/src/arch/mips/cavium-octeon/smp.c: warning: no previous prototype for 'octeon_send_ipi_single' [-Wmissing-prototypes]:  => 100:6
  + /kisskb/src/arch/mips/kernel/cevt-bcm1480.c: warning: no previous prototype for 'sb1480_clockevent_init' [-Wmissing-prototypes]:  => 96:6
  + /kisskb/src/arch/mips/kernel/csrc-bcm1480.c: warning: no previous prototype for 'sb1480_clocksource_init' [-Wmissing-prototypes]:  => 37:13
  + /kisskb/src/arch/mips/mm/c-octeon.c: warning: no previous prototype for 'cache_parity_error_octeon_non_recoverable' [-Wmissing-prototypes]:  => 351:17
  + /kisskb/src/arch/mips/mm/c-octeon.c: warning: no previous prototype for 'cache_parity_error_octeon_recoverable' [-Wmissing-prototypes]:  => 342:17
  + /kisskb/src/arch/mips/mm/c-octeon.c: warning: no previous prototype for 'register_co_cache_error_notifier' [-Wmissing-prototypes]:  => 297:5
  + /kisskb/src/arch/mips/mm/c-octeon.c: warning: no previous prototype for 'unregister_co_cache_error_notifier' [-Wmissing-prototypes]:  => 303:5
  + /kisskb/src/arch/mips/mm/cerr-sb1.c: warning: no previous prototype for 'sb1_cache_error' [-Wmissing-prototypes]:  => 165:17
  + /kisskb/src/arch/mips/pci/msi-octeon.c: warning: no previous prototype for 'octeon_msi_initialize' [-Wmissing-prototypes]:  => 343:12
  + /kisskb/src/arch/mips/pci/pci-octeon.c: warning: no previous prototype for 'octeon_pci_pcibios_map_irq' [-Wmissing-prototypes]:  => 234:12
  + /kisskb/src/arch/mips/pci/pcie-octeon.c: warning: no previous prototype for 'octeon_pcie_pcibios_map_irq' [-Wmissing-prototypes]:  => 1471:5
  + /kisskb/src/arch/mips/sibyte/bcm1480/irq.c: warning: no previous prototype for 'init_bcm1480_irqs' [-Wmissing-prototypes]:  => 200:13
  + /kisskb/src/arch/mips/sibyte/bcm1480/setup.c: warning: no previous prototype for 'bcm1480_setup' [-Wmissing-prototypes]:  => 104:13
  + /kisskb/src/arch/mips/sibyte/bcm1480/smp.c: warning: no previous prototype for 'bcm1480_mailbox_interrupt' [-Wmissing-prototypes]:  => 158:6
  + /kisskb/src/arch/mips/sibyte/bcm1480/smp.c: warning: no previous prototype for 'bcm1480_smp_init' [-Wmissing-prototypes]:  => 49:6
  + /kisskb/src/arch/mips/sibyte/bcm1480/time.c: warning: no previous prototype for 'plat_time_init' [-Wmissing-prototypes]:  => 10:13
  + /kisskb/src/arch/mips/sibyte/swarm/rtc_m41t81.c: warning: no previous prototype for 'm41t81_get_time' [-Wmissing-prototypes]:  => 186:10
  + /kisskb/src/arch/mips/sibyte/swarm/rtc_m41t81.c: warning: no previous prototype for 'm41t81_probe' [-Wmissing-prototypes]:  => 219:5
  + /kisskb/src/arch/mips/sibyte/swarm/rtc_m41t81.c: warning: no previous prototype for 'm41t81_set_time' [-Wmissing-prototypes]:  => 139:5
  + /kisskb/src/arch/mips/sibyte/swarm/rtc_xicor1241.c: warning: no previous prototype for 'xicor_get_time' [-Wmissing-prototypes]:  => 167:10
  + /kisskb/src/arch/mips/sibyte/swarm/rtc_xicor1241.c: warning: no previous prototype for 'xicor_probe' [-Wmissing-prototypes]:  => 203:5
  + /kisskb/src/arch/mips/sibyte/swarm/rtc_xicor1241.c: warning: no previous prototype for 'xicor_set_time' [-Wmissing-prototypes]:  => 108:5
  + /kisskb/src/arch/mips/sibyte/swarm/setup.c: warning: no previous prototype for 'swarm_be_handler' [-Wmissing-prototypes]:  => 59:5
  + /kisskb/src/drivers/net/ethernet/sgi/meth.c: warning: no previous prototype for 'meth_reset' [-Wmissing-prototypes]:  => 271:5
  + /kisskb/src/drivers/watchdog/octeon-wdt-main.c: warning: no previous prototype for 'octeon_wdt_nmi_stage3' [-Wmissing-prototypes]:  => 210:6
  + warning: unmet direct dependencies detected for HOTPLUG_CPU:  => N/A
  + {standard input}: Warning: macro instruction expanded into multiple instructions:  => 339, 338, 285

3 warning improvements:
  - .config: warning: override: reassigning to symbol UML_NET_SLIRP: 15006, 14765 => 
  - /kisskb/src/fs/ext4/readpage.c: warning: the frame size of 1120 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 391:1 => 
  - modpost: WARNING: modpost: lib/test_bitmap: section mismatch in reference: find_next_bit+0x40 (section: .text.unlikely) -> test_print (section: .init.rodata): N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

