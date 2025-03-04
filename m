Return-Path: <linux-kernel+bounces-543038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5571A4D0CE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1791893A81
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D1E13A258;
	Tue,  4 Mar 2025 01:30:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449C213AC1;
	Tue,  4 Mar 2025 01:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051836; cv=none; b=r7bM8Mp4dmXSTMRmSYJloV6LElBLxkS+3DE2cn8QQwYNbZKS++4rJGZ1FXL5aF8Yhve154Du+iMlm2SS+XsRWtZwD/4/mYiN/0rmTxMI1Rljv5elv6gb4M7HV8JTzZ+nc+ZcoqxQbC/iIoJXw9ukos7ucrfxLZOL10fEjiyTh/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051836; c=relaxed/simple;
	bh=8JoIYV2GtWQTDz4HyJ7E6QNN2hNMjfy+UxcKFO1GxDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CBneZFGZ56eHm8sbq1omgpqO82a+87o+WEoYzS/znKqwB856F5z6coLzJYAd8YJxnwCDfw6xUuKcxqaO1U3jue0l0KpWaG6PP34fmyLKSxtih+NsT60wnKXzDVPouRMABhdCp13p1TIVg5n44ulKrr01PKmi2eHMut3x4o1XO0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AAA9FEC;
	Mon,  3 Mar 2025 17:30:47 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 877753F673;
	Mon,  3 Mar 2025 17:30:31 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/15] clk: sunxi-ng: add A523 clock support
Date: Tue,  4 Mar 2025 01:27:50 +0000
Message-ID: <20250304012805.28594-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this is the third drop of the series introducing basic clock support for
the Allwinner A523 family of SoCs, comprising A523, A527, T527, H728. [1]
This fixes the issues Jernej found in his extensive and gratefully
received review, many thanks for that, also to the other reviewers! 
Those changes affect only details, but the rework caused more changes:
the clock definition helper macros got reworked, and the binding turned
out to be wrong, as it ignored the change in the source clock names
(instead just accommodated their changed number). Shoehorning the
differing names into the existing binding document turned out to be
quite hard to follow, so I moved that into a separate yaml file.
For a more detailed changelog, see below.

*************
Please note that the clock numbers changed compared to v1 and v2, so DTs
from that era cannot be used anymore with this driver: you have to update
the DTB. Just copying the binding header and recompiling the DTB should do
the trick, since the symbols stayed mostly the same, at least as far they
are used in the basic DTs we use today.
*************

The SoCs contain *four* CCU components, aside from the usual main clock
device and the PRCM clock (in the always-on-domain), there is an MCU
clock and a CPU clock. This series just adds support for the first two,
the other two don't seem to be required for the basic functionality.

The clock tree of each SoC has always been individual, even though the
main clock *types* mostly remain the same. This time we see three slight
variations: There is an MP clock without the P (shift) part, there is one
with two dividers instead of one divider and one shift field, and certain
clocks require an "update" bit to be set to apply any changes.
The first three patches add support for these new clock types.

Patch 04 and 05 add the DT binding description for the two CCUs, along
with all the clock numbers already defined in the binding headers.
Since the main CCU is massive, and contains a lot of detail, I decided
to split this driver up into 9 patches, simply to help review. I tried
to group them somewhat logically, although this is rather arbitrary, and
just to make each individual patch smaller. I am happy to squash them
all back into one patch once they have been reviewed, for the final
merge. The PRCM CCU is comparably small, so I kept this in one patch.

Interestingly the Allwinner BSP has switched to using the existing sunxi
CCU framework for modelling the clocks (they had their own way before), so
we could theoretically use their code. However when I started working on
this more than a year ago, their files had a GPL-3.0-only license header,
which, according to my research, makes them incompatible for mainline
inclusion. I thus started from "scratch" (adjusting the D1 driver, really).
Meanwhile they seem to have changed the license, and a quick comparison
turned up some differences, some of which seem to be bugs on their, some
on my side, probably. I hope having such a "reference" helps the mainline
code quality, as people can help the review by comparing code.

Given the level of detail required in CCU drivers, I am certain there are
still some bugs in there, also many things that can be improved. But after
starring and editing this for weeks, I feel like it's time for the
community to have a look, so please help with the review, and also test.

Based on v6.14-rc1.

Cheers,
Andre

[1] https://linux-sunxi.org/A523#Family_of_sun55iw3

Changelog v2 .. v3:
- rename PLL_DDR0 to PLL_DDR
- move bogus macro definition from PLL patch to an earlier patch
- adding CLK_SET_RATE_PARENT flags where needed (GPU, eDP, ...)
- remove CLK_SET_RATE_PARENT from clocks with only fixed parents
- add support for clocks with the "update" bit (BIT(27))
- flags IOMMU, MBUS and DRAM clocks as needing "update" bit
- remove leftover comment about missing mux
- fix TCON_TV parent list
- add TCON_LCD2 clock
- export PLL_GPU
- describe MBUS clock properly (was copy&pasted wrongly from D1)
- change MMC clocks to use better macro
- mark SPI and CSI clocks as being dual-divider clocks
- fix wrong DSP parent clock (480 instead of 400 MHz)
- properly implement fanout clocks (describe both dividers)
- fix MBUS gate clocks and add two new ones
- rename dpss clock to display0 and add display1 clocks
- drop non-existing bus_dsp_cfg_clk
- mark r_timer clocks as having no divider
- fix r_pwm mux width
- move DT bindings into separate yaml file
- describe different source clock sets correctly
- add review tags
- remove Chen-Yu's and Conor's tags from changed patches

Changelog v1 .. v2:
- rebase onto v6.14-rc1
- split main CCU definition patch into 9 smaller patches
- rename RST_BUS_VO1_TCONLCD0 to RST_BUS_TCON_LCD2
- insert CLK_PLL_VIDEO3_xx clocks
- add clock for 2nd EMAC
- fix ISP clock definition
- remove BSP comments from clocks now documented in the T527 manual
- add Conor's binding ACKs (with thanks!)

Andre Przywara (15):
  clk: sunxi-ng: mp: introduce dual-divider clock
  clk: sunxi-ng: mp: provide wrappers for setting feature flags
  clk: sunxi-ng: Add support for update bit
  dt-bindings: clk: sunxi-ng: document Allwinner A523 CCU
  dt-bindings: clk: sunxi-ng: add compatible for the A523 PRCM-CCU
  clk: sunxi-ng: Add support for the A523/T527 CCU PLLs
  clk: sunxi-ng: a523: Add support for bus clocks
  clk: sunxi-ng: a523: add video mod clocks
  clk: sunxi-ng: a523: add system mod clocks
  clk: sunxi-ng: a523: add interface mod clocks
  clk: sunxi-ng: a523: add USB mod clocks
  clk: sunxi-ng: a523: remaining mod clocks
  clk: sunxi-ng: a523: add bus clock gates
  clk: sunxi-ng: a523: add reset lines
  clk: sunxi-ng: add support for the A523/T527 PRCM CCU

 .../clock/allwinner,sun55i-a523-ccu.yaml      |   96 +
 drivers/clk/sunxi-ng/Kconfig                  |   10 +
 drivers/clk/sunxi-ng/Makefile                 |    4 +
 drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c      |  248 +++
 drivers/clk/sunxi-ng/ccu-sun55i-a523-r.h      |   14 +
 drivers/clk/sunxi-ng/ccu-sun55i-a523.c        | 1685 +++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun55i-a523.h        |   14 +
 drivers/clk/sunxi-ng/ccu_common.h             |    5 +
 drivers/clk/sunxi-ng/ccu_div.c                |    2 +
 drivers/clk/sunxi-ng/ccu_gate.c               |    4 +
 drivers/clk/sunxi-ng/ccu_mp.c                 |   51 +-
 drivers/clk/sunxi-ng/ccu_mp.h                 |   58 +-
 drivers/clk/sunxi-ng/ccu_mux.c                |    2 +
 include/dt-bindings/clock/sun55i-a523-ccu.h   |  189 ++
 include/dt-bindings/clock/sun55i-a523-r-ccu.h |   37 +
 include/dt-bindings/reset/sun55i-a523-ccu.h   |   88 +
 include/dt-bindings/reset/sun55i-a523-r-ccu.h |   25 +
 17 files changed, 2517 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun55i-a523-ccu.yaml
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun55i-a523-r.h
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun55i-a523.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun55i-a523.h
 create mode 100644 include/dt-bindings/clock/sun55i-a523-ccu.h
 create mode 100644 include/dt-bindings/clock/sun55i-a523-r-ccu.h
 create mode 100644 include/dt-bindings/reset/sun55i-a523-ccu.h
 create mode 100644 include/dt-bindings/reset/sun55i-a523-r-ccu.h

-- 
2.46.3


