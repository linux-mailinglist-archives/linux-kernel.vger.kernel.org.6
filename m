Return-Path: <linux-kernel+bounces-384541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F41039B2B89
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B02C9282207
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACDA1C4A3A;
	Mon, 28 Oct 2024 09:26:12 +0000 (UTC)
Received: from gauss.telenet-ops.be (gauss.telenet-ops.be [195.130.132.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53F242A82
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730107572; cv=none; b=n7V6yiJuUAWjGA4gVsbqpWJZOjmQoIqS0/nLqvS0UgeS6ACBVA4e24sNRW3VU9eFyXd1xNE7eP6j0NzZbjsE5pDueuz3UNklcEUAKHwp1tK6g/XsjRrazT3aIO39aHIb4NS6gjtoqYkVLyEqv89LpZdwmnjOS4BIIyTr/vHp/S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730107572; c=relaxed/simple;
	bh=0qM21kPQtU2crSr/OWZFDQTwwVqyMBytuavlxLkfOKg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RxoOnfqnrHPX2Zllm7k/DfpoFpbcGmfkAefAUtjB+RNCWUUL6bz9R7xlMn3PG4ph3qINa+PHgefLxWdNXvfgNLTk1MWKobdreL+c0ONdSx8UGfEWJmuyW+G9Pc46GHMz3cSKAkVoIw/ykCsaEtWJFVKSXRIkROiRV0zcERlxRfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
	by gauss.telenet-ops.be (Postfix) with ESMTPS id 4XcSVg32J2z4wyH2
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:18:35 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:36d7:1bde:6f22:dc65])
	by albert.telenet-ops.be with cmsmtp
	id VlJU2D0061znq4j06lJUca; Mon, 28 Oct 2024 10:18:28 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1t5Lt4-005hqe-Qd
	for linux-kernel@vger.kernel.org;
	Mon, 28 Oct 2024 10:18:28 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1t5LtM-00EOXF-1f
	for linux-kernel@vger.kernel.org;
	Mon, 28 Oct 2024 10:18:28 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v6.12-rc5
Date: Mon, 28 Oct 2024 10:18:28 +0100
Message-Id: <20241028091828.3430883-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHk-=whHB3RxR15Xk8Epah8ZrRJi-7ZevSu6kBp0MFtjXEvM-w@mail.gmail.com>
References: <CAHk-=whHB3RxR15Xk8Epah8ZrRJi-7ZevSu6kBp0MFtjXEvM-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Below is the list of build error/warning regressions/improvements in
v6.12-rc5[1] compared to v6.11[2].

Summarized:
  - build errors: +4/-3
  - build warnings: +33/-3

JFYI, when comparing v6.12-rc5[1] to v6.12-rc4[3], the summaries are:
  - build errors: +4/-0
  - build warnings: +0/-0

Note that there may be false regressions, as some logs are incomplete.
Still, they're build errors/warnings.

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/81983758430957d9a5cb3333fe324fd70cf63e7e/ (all 194 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/98f7e32f20d28ec452afb208f9cffc08448a2652/ (131 out of 194 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/42f7652d3eb527d03665b09edac47f85fb600924/ (all 194 configs)


*** ERRORS ***

4 error regressions:
  + /kisskb/src/crypto/async_tx/async_tx.c: error: no previous prototype for '__async_tx_find_channel' [-Werror=missing-prototypes]:  => 43:1
  + /kisskb/src/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t {aka long long unsigned int}' [-Werror=format=]:  => 126:37
  + /kisskb/src/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Werror=format=]:  => 126:46
  + {standard input}: Error: pcrel too far: 1059, 1061, 1060 => 1061, 1060, 1059, 1397

3 error improvements:
  - /kisskb/src/drivers/md/dm-integrity.c: error: logical not is only applied to the left hand side of comparison [-Werror=logical-not-parentheses]: 4720:45 => 
  - /kisskb/src/drivers/media/platform/nxp/imx-pxp.h: error: initializer element is not constant: 582:38 => 
  - {standard input}: Error: unknown pseudo-op: `.siz': 1273 => 


*** WARNINGS ***

33 warning regressions:
  + .config: warning: override: reassigning to symbol MIPS_CPS_NS16550_SHIFT: 15216, 15210 => 15350, 15344, 15342
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
  + warning: unmet direct dependencies detected for GET_FREE_REGION:  => N/A
  + warning: unmet direct dependencies detected for HOTPLUG_CPU:  => N/A
  + {standard input}: Warning: macro instruction expanded into multiple instructions:  => 338, 339, 285

3 warning improvements:
  - .config: warning: override: reassigning to symbol UML_NET_SLIRP: 14765, 15006 => 
  - /kisskb/src/fs/ext4/readpage.c: warning: the frame size of 1120 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 391:1 => 
  - modpost: WARNING: modpost: lib/test_bitmap: section mismatch in reference: find_next_bit+0x40 (section: .text.unlikely) -> test_print (section: .init.rodata): N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

