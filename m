Return-Path: <linux-kernel+bounces-318177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C3796E982
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 07:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D8B1C21447
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 05:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD68E13B5AF;
	Fri,  6 Sep 2024 05:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKA+dOgt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA2483A18;
	Fri,  6 Sep 2024 05:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725601957; cv=none; b=OSgV0HfaA1kU0uCFgrjmlQA+eLM/zTjFfII3xeYpMGyCjg034Rp8ZW5EGnns85uI3vE50fU1ngTzToJyRspDghyjBS8kIA9VwCtJ8k15caa+gjVI0lm5s6sjC/8kb633O2QYJNQwC5RGMH5Pu0royI1vLZS0Z3QZ+aTdGa4sRIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725601957; c=relaxed/simple;
	bh=g01KSPJoXIPurLe84AcyOHvY7DI2Ak8ynhEFBJfoOtg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SDPpuOV01BA2wQLz57du6J8ksMb4IJX1/2QfWJydf8V1rFXZ1gr589esXr2jQm1ihRpmbmoiiAACoNiy1vsdIDJJkfpARLi05SqzKKPUgv4UtAKdrDk+nm7mdzEayCit3TpdMWRjjee3yOh1DX0TCXc6k7HwF0LJpahk6G1NrCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKA+dOgt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF551C4CEC4;
	Fri,  6 Sep 2024 05:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725601956;
	bh=g01KSPJoXIPurLe84AcyOHvY7DI2Ak8ynhEFBJfoOtg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=tKA+dOgttwwsbZFDX0yViM54k+PSdYvK9glYNgdUAgx7tA48HGEhZUiYMQirQHNNq
	 vziGbqVkZkqUn797wPX8dSXhjE8KpNc2fl2/h1yScVNbRIfYGhRXGgU9Bgv/cnsEwy
	 hg1vGh8xCCKl6nkU2LfrGAWW8Q5pYYRZSRe8B7yFj39QFQ88Cvk7UewyY1VXojgmMJ
	 G0yplYeaR4IvJ637ySmGCxUI4Mu+oGoT1vYvn6l3V8LpE33/1vOiKsDrzeaGK/nPbN
	 Ps8EkwNmMpubGrQkTrrLQCeLvBrIlnaVSPUH2ob0bggbcOTLpGtr8rYI7pqpkMt92F
	 A0UYPs9rqghwg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B15C54FC6;
	Fri,  6 Sep 2024 05:52:36 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Subject: [PATCH 0/4] clk: meson: Fix an issue with inaccurate hifi_pll
 frequency
Date: Fri, 06 Sep 2024 13:52:32 +0800
Message-Id: <20240906-fix_clk-v1-0-2977ef0d72e7@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKCY2mYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSwMT3bTMivjknGxdMzOLNPNEw0SjJEMzJaDqgqJUoBTYpOjY2loAryT
 uhFkAAAA=
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725601955; l=1915;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=g01KSPJoXIPurLe84AcyOHvY7DI2Ak8ynhEFBJfoOtg=;
 b=XOPNho1g4xaPZsvq42GBw4qtdRF1HzWnaEFGPdOhELlSCEJOlNnmLj11KCyoC+vmwCDfw/SzU
 R0GqjapV8XlA3dJXBmuCQcEr9UMihJD+wZRxX8G2C3dd7VdbzhpMB49
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

Some PLLs with fractional multipliers have fractional denominators that
are fixed to "100000" instead of the previous "(1 << pll->frac.width)".

The hifi_pll for both C3 and S4 supports a fractional multiplier and has
a fixed fractional denominator of "100000".

Here are the results of the C3-based command tests (already defined
CLOCK_ALLOW_WRITE_DEBUGFS):
* echo 491520000 > /sys/kernel/debug/clk/hifi_pll/clk_rate
* cat /sys/kernel/debug/clk/hifi_pll/clk_rate
491520000
* echo 1 > /sys/kernel/debug/clk/hifi_pll/clk_prepare_enable
* cat /sys/kernel/debug/meson-clk-msr/clks/hifi_pll_clk
491515625       +/-15625Hz
* devmem 0xfe008100 32
0xD00304A3
* devmem 0xfe008104 32
0x00014820

Based on the register information read above, it can be obtained:
m = 0xA3 = 0d163;
n = 0x1 = 0d1
frac = 0x14820 = 0d84000
od = 0x3 = 0d3

hifi_pll calculates the output frequency:
calc_rate = xtal_rate / n * (m + (frac / frac_max)) >> od;
calc_rate = 24000000 / 1 * (163 + (84000 / 100000)) >> 3;
calc_rate = 491520000

clk_rate, msr_rate, and calc_rate all match.

The test and calculation results of S4 are consistent with those of C3,
which will not be repeated here.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
Chuan Liu (4):
      clk: meson: Support PLL with fixed fractional denominators
      clk: meson: c3: pll: hifi_pll frequency is not accurate
      clk: meson: s4: pll: hifi_pll support fractional multiplier
      clk: meson: s4: pll: hifi_pll frequency is not accurate

 drivers/clk/meson/c3-pll.c  |  1 +
 drivers/clk/meson/clk-pll.c | 22 +++++++++++++++++++---
 drivers/clk/meson/clk-pll.h |  1 +
 drivers/clk/meson/s4-pll.c  |  9 +++++++--
 4 files changed, 28 insertions(+), 5 deletions(-)
---
base-commit: adac147c6a32e2919cb04555387e12e738991a19
change-id: 20240904-fix_clk-668f7a1a2b16

Best regards,
-- 
Chuan Liu <chuan.liu@amlogic.com>



