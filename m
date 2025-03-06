Return-Path: <linux-kernel+bounces-549561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DC4A553F0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 542653A66AF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9110926B0B8;
	Thu,  6 Mar 2025 18:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="YBH99TsV";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="QvFlMvlP"
Received: from bayard.4d2.org (bayard.4d2.org [155.254.16.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF3125CC88;
	Thu,  6 Mar 2025 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.254.16.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283999; cv=none; b=Za1JEUwAgvlqlT1RHtOngIOd2VCCYtSDgIvVL//juzJKMSW+u9g+PD3dYfvK96CO1bB3RC84w8/UzOa9vrtIapkODIgppyV9K2+V7IEQZLIvtdAXAshoOTkeN1vCFLj3x6zhBj8rfkpSh+0uKkF5TOPa1HND2D9gIEfWg2HO+i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283999; c=relaxed/simple;
	bh=Yw1n6v5hNvDiqN1eYZkeAUubqnzwc9HWGRsVQHuzjNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MDkRMy8c+5iWCa85qVRMdmeWvrQlvSYkPQwAy3rGnuZdV/LVMyYdGW5b5Io3j5qjzrcGz72cuD9LtNnGGztPOmN6A6cuuhDmOIm8W+cI6W/7VKJOHn9Dp3qCdvJY95tWLsolYgYmHZyMBEk26ThvGxm/1kYN4RuV5ITfDp3VgLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=YBH99TsV; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=QvFlMvlP; arc=none smtp.client-ip=155.254.16.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from bayard.4d2.org (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id 759D0EC59F8;
	Thu, 06 Mar 2025 09:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1741283989; bh=Yw1n6v5hNvDiqN1eYZkeAUubqnzwc9HWGRsVQHuzjNw=;
	h=From:To:Cc:Subject:Date:From;
	b=YBH99TsV/YpwgAqDPHCN4SeETkt7w5iU0BzPNLS+3sP8bQQmoamfRl7jFpXV6gkO5
	 L2SEsX+R3WBcyZdTUl6xPb9hfOd0LzK1zRg4EjNUbBrYnnCEWlT/bCDK+5ZRdp0SS8
	 Z00OzYQPC7vZ2nkK8L9ZjixNSQDKTtvqD2wknzmisgomtQrwSKylLF2c6aJQU31eDf
	 vvsRHKkEQAUgQ9IjhyRqKlrKoPqJm+FrfPOAq29zMWR/pp1XMQ3mneaNd8zs5XpBzj
	 SYqsSXaPh6qqNL9OB3WWT3z8mj/o+JjN+g6PGfHF6pdW0dwR5zdd8EHMGlDvX1vXak
	 6X3WL7Nrh21lQ==
X-Virus-Scanned: amavisd-new at 4d2.org
Authentication-Results: bayard.4d2.org (amavisd-new); dkim=pass (2048-bit key)
 header.d=4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by bayard.4d2.org (bayard.4d2.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eabRI32M_UJV; Thu,  6 Mar 2025 09:59:47 -0800 (PST)
Received: from localhost.localdomain (unknown [183.217.80.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id E9A03EC59F2;
	Thu, 06 Mar 2025 09:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1741283987; bh=Yw1n6v5hNvDiqN1eYZkeAUubqnzwc9HWGRsVQHuzjNw=;
	h=From:To:Cc:Subject:Date:From;
	b=QvFlMvlPZ+Tcl72h1v31ByLCyEIpX9QnzhbdJm/2wnPrG1SF9BxPRDsoznyJbSFR/
	 YtlftR4FxF/oxT52tImQPoxpoNFLboXqja6m0E9NyPalj9QLIUBkAxIt1R/wLSN8uX
	 3zEolKr2ppHkToVmF7uA15rMl17BP3JtzsgAWpONtz3n1q7BL7QUge2AuZtc9pAztR
	 auyVblLj7f+XNHu2zyWkcKtzUayG2+2TfZU0H5VN1sW5WwK2oLCMQYj7PR8omWt877
	 F2RtsjNRLDTmLZerdWZoQMVdmbiZVJLNqYCwmNUVrOJBS3qMdvLwraH+fX/sgfnCJq
	 uUYHDoDjxL3+g==
From: Haylen Chu <heylenay@4d2.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Haylen Chu <heylenay@outlook.com>,
	Yixun Lan <dlan@gentoo.org>
Cc: linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	spacemit@lists.linux.dev,
	Inochi Amaoto <inochiama@outlook.com>,
	Chen Wang <unicornxdotw@foxmail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
	Haylen Chu <heylenay@4d2.org>
Subject: [PATCH v5 0/5] Add clock controller support for SpacemiT K1
Date: Thu,  6 Mar 2025 17:57:46 +0000
Message-ID: <20250306175750.22480-2-heylenay@4d2.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clock tree of SpacemiT K1 is managed by several independent
multifunction devices, some of them are

- Application Power Manage Unit, APMU
- Main Power Manage Unit, MPMU
- APB Bus Clock Unit, APBC
- APB Spare, APBS

These four devices provide hardware bits for three purposes: power
management, reset signals and clocks. Not every device is capable of all
the three functionalities,

- APMU, MPMU: power, reset, clock
- APBC: clock, reset
- APBS: clock (PLL clocks)

This series adds support for clock hardwares in these four regions,
which covers most peripherals except DDR and the realtime processor.

Tested on BananaPi-F3 board. With some out-of-tree drivers, I've
successfully brought up I2C, RTC, MMC and ethernet controllers. A clock
tree dump could be obtained here[1].

[1]: https://gist.github.com/heylenayy/4c88630454d5ad26c9336592673eb187

Changed from v4
- bindings:
  - Drop CLK_*_NUM macros from binding headers
  - Rename spacemit,k1-ccu.yaml to spacemit,k1-pll.yaml, change to
    describe only the PLL in APBS region
  - k1-syscon.yaml
    - drop spacemit,k1-syscon-apbs, it should be the PLL device
    - drop child nodes
    - describe the syscons as clock, reset and power-domain controllers
    - drop "syscon" from the compatible list, as these syscons aren't
      compatible with the generic one
- driver:
  - misc style fixes and naming improvements
  - drop unused fields from data structures
  - drop unused clock types: CCU_DDN_GATE
  - ddn type:
    - improve the comments
    - dynamically calculate appropriate rates
    - hardcode the x2 factor
  - mix type
    - drop val_{disable,enable} for gate subtype
    - drop unncessary polling when enabling a gate
    - encode subtypes directly in struct ccu_mix
    - generate clock names from identifiers of the data structure
    - rename CCU_DIV2_FC_MUX_GATE_DEFINE to CCU_DIV_SPLIT_FC_MUX_GATE
  - pll type:
    - correctly claim the parent clock
    - make rate tables const
    - drop SWCR2-related fields
    - combine fields of registers as a whole instead of working with
      each field
  - clock tree for k1:
    - removed duplicated offsets
    - drop the placeholder 1:1 factor, pll1_d7_351p8
    - workaround the quirk of TWSI8 clocks
    - fix the definition of ripc_clk, wdt_bus_clk, dpu_bit_clk and
      timers_*_clk
    - drop structure spacemit_ccu_priv and spacemit_ccu_data
    - rework clock registration
    - split the PCIe clocks correctly (there're three distinct clocks
      for each PCIe port)
- devicetree:
  - adapt the new binding
- Link to v4: https://lore.kernel.org/all/20250103215636.19967-2-heylenay@4d2.org/

Changed from v3
- spacemit,k1-ccu binding
  - allow spacemit,mpmu property only for controllers requiring it
    (spacemit,k1-ccu-apbs)
- spacemit,k1-syscon binding
  - drop unnecessary *-cells properties
  - drop unrelated nodes in the example
- driver
  - remove unnecessary divisions during rate calucalation in ccu_ddn.c
  - use independent clk_ops for different ddn/mix variants, drop
    reg_type field in struct ccu_common
  - make the register containing frequency change bit a sperate field in
    ccu_common
  - unify DIV_MFC_MUX_GATE and DIV_FC_MUX_GATE
  - implement a correct determine_rate() for mix type
  - avoid reparenting in set_rate() for mix type
  - fix build failure when SPACEMIT_CCU and SPACEMIT_CCU_K1 are
    configured differently
- use "osc" instead of "osc_32k" in clock input names
- misc style fixes
- Link to v3: https://lore.kernel.org/all/20241126143125.9980-2-heylenay@4d2.org/

Changed from v2
- dt-binding fixes
  - drop clocks marked as deprecated by the vendor (CLK_JPF_4KAFBC and
    CLK_JPF_2KAFBC)
  - add binding of missing bus clocks
  - change input clocks to use frequency-aware and more precise names
  - mark input clocks and their names as required
  - move the example to the (parent) syscon node and complete it
  - misc style fixes
- misc improvements in code
- drop unnecessary spinlock in the driver
- implement missing bus clocks
- Link to v2: https://lore.kernel.org/all/SEYPR01MB4221829A2CD4D4C1704BABD7D7602@SEYPR01MB4221.apcprd01.prod.exchangelabs.com/

Changed from v1
- add SoC prefix (k1)
- relicense dt-binding header
- misc fixes and style improvements for dt-binding
- document spacemit,k1-syscon
- implement all APBS, MPMU, APBC and APMU clocks
- code cleanup
- Link to v1: https://lore.kernel.org/all/SEYPR01MB4221B3178F5233EAB5149E41D7902@SEYPR01MB4221.apcprd01.prod.exchangelabs.com/

Haylen Chu (5):
  dt-bindings: soc: spacemit: Add spacemit,k1-syscon
  dt-bindings: clock: spacemit: Add spacemit,k1-pll
  clk: spacemit: Add clock support for Spacemit K1 SoC
  clk: spacemit: k1: Add TWSI8 bus and function clocks
  riscv: dts: spacemit: Add clock tree for Spacemit K1

 .../bindings/clock/spacemit,k1-pll.yaml       |   50 +
 .../soc/spacemit/spacemit,k1-syscon.yaml      |   80 +
 arch/riscv/boot/dts/spacemit/k1.dtsi          |   79 +
 drivers/clk/Kconfig                           |    1 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/spacemit/Kconfig                  |   20 +
 drivers/clk/spacemit/Makefile                 |    5 +
 drivers/clk/spacemit/ccu-k1.c                 | 1720 +++++++++++++++++
 drivers/clk/spacemit/ccu_common.h             |   47 +
 drivers/clk/spacemit/ccu_ddn.c                |   80 +
 drivers/clk/spacemit/ccu_ddn.h                |   48 +
 drivers/clk/spacemit/ccu_mix.c                |  284 +++
 drivers/clk/spacemit/ccu_mix.h                |  246 +++
 drivers/clk/spacemit/ccu_pll.c                |  146 ++
 drivers/clk/spacemit/ccu_pll.h                |   76 +
 include/dt-bindings/clock/spacemit,k1-ccu.h   |  247 +++
 16 files changed, 3130 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/spacemit,k1-pll.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
 create mode 100644 drivers/clk/spacemit/Kconfig
 create mode 100644 drivers/clk/spacemit/Makefile
 create mode 100644 drivers/clk/spacemit/ccu-k1.c
 create mode 100644 drivers/clk/spacemit/ccu_common.h
 create mode 100644 drivers/clk/spacemit/ccu_ddn.c
 create mode 100644 drivers/clk/spacemit/ccu_ddn.h
 create mode 100644 drivers/clk/spacemit/ccu_mix.c
 create mode 100644 drivers/clk/spacemit/ccu_mix.h
 create mode 100644 drivers/clk/spacemit/ccu_pll.c
 create mode 100644 drivers/clk/spacemit/ccu_pll.h
 create mode 100644 include/dt-bindings/clock/spacemit,k1-ccu.h

-- 
2.48.1


