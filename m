Return-Path: <linux-kernel+bounces-574469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91303A6E5B6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E26E189286D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F8F1A254E;
	Mon, 24 Mar 2025 21:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6pVrZkQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800C2EC4
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742852026; cv=none; b=BOMySvhQFN2AmCeh3A/OCTO6QuC8QInthE+ajhMchQIKQY0Vm6A6XsbPxfTVIUqbzcoFXXhdWNrANZxApPyKbPvhtrGRszJE3SIE8J1GBo6mQ+Yg6x0/XmCtowkMrmB2gm20aGYlw4LLiRT0Bm3wn3d35K3xgykjji4Ya45+wvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742852026; c=relaxed/simple;
	bh=gvtFPg92j2IlNK8PyXb1c01xAnOHXBZXWy56YSAh8MU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YHarqqpE6JkYEIrnaUH29Fkc3H61GrE2I12/tpHrWqyJuGhQTXezMfVQcozP0NpdWABg4wisX+IXhL1xkIa1iqkEYn2+y2mRQsrct8pqeW3Isx6HbYz57YGTn3A8mOLiy5HU1szEvmfOeZb4z9ZmxNIP5i246NWpGQWtMK2RNQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6pVrZkQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E792C4CEDD;
	Mon, 24 Mar 2025 21:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742852025;
	bh=gvtFPg92j2IlNK8PyXb1c01xAnOHXBZXWy56YSAh8MU=;
	h=From:To:Cc:Subject:Date:From;
	b=Y6pVrZkQAtvmJocHyy54S2VCSV3ZGRX8VbOEXfG/dzt1tQG24+aO06QhGrhxge1tD
	 z2qMP3Qw5ZeQmpA08VMCzUpqtd7aHYGVnYSRN3xaAR1r0kq9iZ3a9MAOAjSWK/LeTT
	 OQa0yZqh2ckTV1iqVyRxVenL5bSMgHNP11arZio8bPwR7MiBXHXZ/9KdHE1MtFqv1i
	 sn4lhcgfXa1CfOGdgG8cjEWQbNUUTuvT8Yg+WTtjD5n5vnq6QwMWXb+EnOpnwr99oR
	 +TG0Asp+c3cz0ECo6xkKiLagDOHncYLU8ROjjmsxHZ1xqTDzw585CC9iIdNyTdWwd7
	 TTlBv3uQdnr2g==
From: Arnd Bergmann <arnd@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Stephen Boyd <sboyd@kernel.org>,
	David Lechner <david@lechnology.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>,
	David Lechner <dlechner@baylibre.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: davinci: always enable CONFIG_ARCH_DAVINCI_DA850
Date: Mon, 24 Mar 2025 22:33:35 +0100
Message-Id: <20250324213340.4129384-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

A change to the clk driver broke configurations that enable DA830
but not DA850:

arm-linux-gnueabi-ld: drivers/clk/davinci/pll.o: in function `__da850_pll0_of_clk_init_declare':
pll.c:(.init.text+0x30): undefined reference to `of_da850_pll0_init'
arm-linux-gnueabi-ld: drivers/clk/davinci/pll.o:(.rodata.davinci_pll_id_table+0x14): undefined reference to `da850_pll0_init'
arm-linux-gnueabi-ld: drivers/clk/davinci/pll.o:(.rodata.davinci_pll_id_table+0x2c): undefined reference to `da850_pll1_init'
arm-linux-gnueabi-ld: drivers/clk/davinci/pll.o:(.rodata.davinci_pll_of_match+0xc0): undefined reference to `of_da850_pll1_init'
arm-linux-gnueabi-ld: drivers/clk/davinci/psc.o:(.rodata.davinci_psc_id_table+0x14): undefined reference to `da850_psc0_init_data'
arm-linux-gnueabi-ld: drivers/clk/davinci/psc.o:(.rodata.davinci_psc_id_table+0x2c): undefined reference to `da850_psc1_init_data'

Select ARCH_DAVINCI_DA850 unconditionally to ensure the driver can still
build.

Fixes: a31b4dcf188c ("clk: davinci: remove support for da830")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-davinci/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 3fa15f342240..8f66de0405d9 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -4,6 +4,7 @@ menuconfig ARCH_DAVINCI
 	bool "TI DaVinci"
 	depends on ARCH_MULTI_V5
 	depends on CPU_LITTLE_ENDIAN
+	select ARCH_DAVINCI_DA850
 	select CPU_ARM926T
 	select DAVINCI_TIMER
 	select ZONE_DMA
-- 
2.39.5


