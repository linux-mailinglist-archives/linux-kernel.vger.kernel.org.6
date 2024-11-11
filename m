Return-Path: <linux-kernel+bounces-403417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B352B9C3570
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 01:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78BA9281F7A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 00:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F74EAC6;
	Mon, 11 Nov 2024 00:47:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE7DAD27;
	Mon, 11 Nov 2024 00:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731286057; cv=none; b=ZvD7m8nytX1xBu87O+gcsAnlmTxJM30EtOT7MhCqZZ5qvWiKyZTI0StgC4cCSGrFDErdX920zGlszrqR8OSOEsvfart6SbcFIN/8ulxk98oiRM3D14sMCXe8lygMUBc5EFC8kme89u3NW6NQACE5Z9rTnLjySn3jB1jSNAHtfL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731286057; c=relaxed/simple;
	bh=5XhGvI9Io2LeYdUemVz3vOHCk6n3vd4kGN9IU8oB3b0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VuC116BNsss8tvjuBaoAz3yHDtY6W21imuNxPHABstj86jWCIq2v3GGlSrD4aVI4vKUcgCyzb55e7f0yBZ8DwASRsJ2sJAqJ9HF0zhSzfkGaUBkaAcfW0Nfi27n0+L7pyDRWQqbGjP6vDpDl/+Helly4JmJFZKeVVa80LpTAxQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66DB113D5;
	Sun, 10 Nov 2024 16:48:02 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 796333F66E;
	Sun, 10 Nov 2024 16:47:30 -0800 (PST)
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
	Icenowy Zheng <uwu@icenowy.me>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] clk: sunxi-ng: add A523 clock support
Date: Mon, 11 Nov 2024 00:47:15 +0000
Message-ID: <20241111004722.10130-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this series introduces basic clock support for the Allwinner A523 family
of SoCs (comprising A523, A527, T527). [1]
The SoC contains *four* CCU components, aside from the usual main clock
device and the PRCM clock (in the always-on-domain), there is an MCU
clock and a DSP clock. This series just adds support for the first two,
the other two don't seem to be required for the basic functionality.

The clock tree of each SoC has always been individual, even though the
main clock *types* mostly remain the same. This time we see two slight
variations: There is an MP clock without the P (shift) part, and there
is one with two dividers instead of one divider and one shift field.
The first three patches add support for these new clock types.

The remaining four patches then add the DT bindings documentation and
describe all the clocks and their relationship in gory detail.
I split the binding patches up, since they contain the header files
naming the clocks, let me know if they should be in one patch instead.

Interestingly the Allwinner BSP has switched to using the existing sunxi
CCU framework for modelling the clocks (they had their own way before), so
we could theoretically use their code. However when I started working on
this about a year ago, their files had a GPL-3.0-only license header,
which, according to my research, makes them incompatible for mainline
inclusion. I thus started from "scratch" (adjusting the D1 driver, really).
Meanwhile they seem to have changed the license, and a quick comparison
turned up some differences, some of which seem to be bugs on their, some
on my side, probably. I hope having such a "reference" helps the mainline
code quality, as people can help the review by comparing code.

Also we only have a user manual for the A523, but its siblings introduce
more clocks (HDMI, NPU, etc.). I tried to close the gaps by looking at
some BSP code, and also by probing registers on actual hardware, to see
which clocks implement which bits.

Given the level of detail required in CCU drivers, I am certain there are
many bugs in there, also many things that can be improved. But after
starring and editing this for weeks, I feel like it's time for the
community to have a look, so please help with the review, and also test.

Based on v6.12-rc1.

Cheers,
Andre

[1] https://linux-sunxi.org/A523#Family_of_sun55iw3

Andre Przywara (7):
  clk: sunxi-ng: mp: Add SUNXI_CCU_P_DATA_WITH_MUX_GATE wrapper
  clk: sunxi-ng: mp: introduce dual-divider clock
  clk: sunxi-ng: mp: provide wrapper for setting feature flags
  dt-bindings: clk: sunxi-ng: add compatible for the A523 CCU
  dt-bindings: clk: sunxi-ng: add compatible for the A523 PRCM-CCU
  clk: sunxi-ng: Add support for the A523/T527 CCU
  clk: sunxi-ng: add support for the A523/T527 PRCM CCU

 .../clock/allwinner,sun4i-a10-ccu.yaml        |   76 +-
 drivers/clk/sunxi-ng/Kconfig                  |   10 +
 drivers/clk/sunxi-ng/Makefile                 |    4 +
 drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c      |  245 +++
 drivers/clk/sunxi-ng/ccu-sun55i-a523-r.h      |   14 +
 drivers/clk/sunxi-ng/ccu-sun55i-a523.c        | 1628 +++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun55i-a523.h        |   14 +
 drivers/clk/sunxi-ng/ccu_common.h             |    1 +
 drivers/clk/sunxi-ng/ccu_mp.c                 |   51 +-
 drivers/clk/sunxi-ng/ccu_mp.h                 |   39 +-
 include/dt-bindings/clock/sun55i-a523-ccu.h   |  187 ++
 include/dt-bindings/clock/sun55i-a523-r-ccu.h |   36 +
 include/dt-bindings/reset/sun55i-a523-ccu.h   |   87 +
 include/dt-bindings/reset/sun55i-a523-r-ccu.h |   25 +
 14 files changed, 2377 insertions(+), 40 deletions(-)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun55i-a523-r.h
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun55i-a523.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun55i-a523.h
 create mode 100644 include/dt-bindings/clock/sun55i-a523-ccu.h
 create mode 100644 include/dt-bindings/clock/sun55i-a523-r-ccu.h
 create mode 100644 include/dt-bindings/reset/sun55i-a523-ccu.h
 create mode 100644 include/dt-bindings/reset/sun55i-a523-r-ccu.h

-- 
2.46.2


