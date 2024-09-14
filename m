Return-Path: <linux-kernel+bounces-329118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B34978DA3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 07:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BACD1F234C4
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 05:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8803583CDB;
	Sat, 14 Sep 2024 05:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPLP5TJY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF6A44C8C;
	Sat, 14 Sep 2024 05:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726291532; cv=none; b=DMny2r2+izun2p8frZbsfVvSNt/Fi3vTvg/3psXm63yif1ILHeBuPk0yw6AuAu75IOdCxoS7xEzlz2s7xP0jUBhkig9jXAN5vwFJ4oX8zxpMK4AIUUIKVm8HgtQriHXHLUNIcsY3wO/KL4eudeceq2HkpBR9L4jxHqt2OcrTvNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726291532; c=relaxed/simple;
	bh=y10UL2fiKM6zXqdv45T+NCDp2jd43U6zrfE3QLH15qU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NsGv82Q8wX5Efa/oD1YErUaSDM4yaydaiHD8YxIIP047z2/vpmfD/4YHOgSguLLuQrVB87Di/E6905AiLkjsKTH2Q19+66vp26IygDSdmL0Y+ylKYsFtew0OR8agTQEyAzXqOCzz3cSACKqwuhvRm28pBzPhB5JvoJr7fPcMvG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPLP5TJY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 541BAC4CECC;
	Sat, 14 Sep 2024 05:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726291532;
	bh=y10UL2fiKM6zXqdv45T+NCDp2jd43U6zrfE3QLH15qU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=nPLP5TJYWkdJdEgOCEQ5vpb+KiRf/nRbnZ+G9jyjppMeoMFCGpD4ZQSdvHkYqtiCS
	 O9ySghrOtoXSZwuLmg/P635Lw4E2/2aiFzCtozHyXxFz9D/K8vB97L1FBkxC8CnNsF
	 WwoTJWdjIcYbospS/JHpDPpOWjKC+FMHe+teS1gQd2/7AMcPcU2Lmeccqod6S44pr8
	 gEOy4obLpVGS41j5G69tQsHkNvF8FHyCFMTexFSQVqosbku6Y/AZye6Xh51fPSXVIQ
	 1F5a69Cn7AiRkDn0rLrUr3bVoVzjtmOp3KtPkQsOKLk7pBT7dCK1PiWg3/46+Jr96V
	 xKtXcwJ23cLOg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD82FA374E;
	Sat, 14 Sep 2024 05:25:32 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH 0/5] Add A5 SoC PLLs and Peripheral clock
Date: Sat, 14 Sep 2024 13:25:22 +0800
Message-Id: <20240914-a5-clk-v1-0-5ee2c4f1b08c@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEIe5WYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDS0ND3URT3eScbF1j02QTy8TkJGOTVEMloOKCotS0zAqwQdGxtbUAVqX
 Sv1gAAAA=
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chuan Liu <chuan.liu@amlogic.com>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726291530; l=1750;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=y10UL2fiKM6zXqdv45T+NCDp2jd43U6zrfE3QLH15qU=;
 b=sUAB/u6hyKEzqV+R2fe113uLL+QgpGEdnrQzsqmHoS4LtwcUOpqrDytQM0YYlyT5HmDUqn3l5
 n9qfi5GZ0DwBdITVtOTKWoe3YbR/qVjhcoZn7RJXksRTcBduZShmnUR
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

The patchset adds support for the peripheral and PLL clock controller
found on the Amlogic A5 SoC family, such as A113X2.

Some clocks are provided by security zones. These clock accessed
througth SCMI driver in linux, inlcuding OSC, SYS_CLK, AXI_CLK,
CPU_CLK, DSU_CLK, GP1_PLL, FIXED_PLL_DCO, FIXED_PLL, SYS_PLL_DIV16,
ACLKM, CPU_CLK_DIV16, FCLK_50M_PREDIV, FCLK_50M_DIV, FCLK_50M, 
FCLK_DIV2_DIV, FCLK_DIV2, FCLK_DIV2P5_DIV, FCLK_DIV2P5, FCLK_DIV3_DIV,
FCLK_DIV3, FCLK_DIV4_DIV, FCLK_DIV4, FCLK_DIV5_DIV, FCLK_DIV5,
FCLK_DIV7_DIV and FCLK_DIV7.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Chuan Liu (5):
      dt-bindings: clock: add Amlogic A5 PLL clock controller
      dt-bindings: clock: add Amlogic A5 SCMI clock controller support
      dt-bindings: clock: add Amlogic A5 peripherals clock controller
      clk: meson: add support for the A5 SoC PLL clock
      clk: meson: add A5 clock peripherals controller driver

 .../clock/amlogic,a5-peripherals-clkc.yaml         |  126 ++
 .../bindings/clock/amlogic,a5-pll-clkc.yaml        |   62 +
 drivers/clk/meson/Kconfig                          |   28 +
 drivers/clk/meson/Makefile                         |    2 +
 drivers/clk/meson/a5-peripherals.c                 | 1471 ++++++++++++++++++++
 drivers/clk/meson/a5-pll.c                         |  553 ++++++++
 .../clock/amlogic,a5-peripherals-clkc.h            |  139 ++
 include/dt-bindings/clock/amlogic,a5-pll-clkc.h    |   24 +
 include/dt-bindings/clock/amlogic,a5-scmi-clkc.h   |   37 +
 9 files changed, 2442 insertions(+)
---
base-commit: c92651b5d51738859098d59692ff8ff4fa85bcd6
change-id: 20240911-a5-clk-35c49acb34e1

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



