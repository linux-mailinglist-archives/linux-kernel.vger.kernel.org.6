Return-Path: <linux-kernel+bounces-415280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3040A9D33E6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA1E82835A2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 07:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2512168488;
	Wed, 20 Nov 2024 07:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqlrqZv7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F65E15533F;
	Wed, 20 Nov 2024 07:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732086076; cv=none; b=IdDATjxUgEd9Q7zaBenoxDyYhD1dBQ0k1BasTv1329LGFORrVaGW95zNM0OWMOLKf7zR5P+qEEWZC/KRvkngwpTS5UXZvTgZLgzAs6m56OSs+0mPlu3BtN62jWD7sVsciSpZjXv72pyy/i/h/kWD0Daf7/VqXR7Ks1tD8f+DH8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732086076; c=relaxed/simple;
	bh=oaMqr8221d4dNAMOE6HnSj3j2CboaMXhg2FJ5tzAdbY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F71GfX/8OGxEw/1dBVsAEYHiCidBTGjs1H+2zrm8XwznITOGcBzGgI+E153bG/kZJlMN0PTX3rrG4OfQiSDhw+5uU5Uqkhuf7n1qDoiAno+QP0gcMektW43rjHJBhbL+bp/ldot2dLdeOPa+bPZAGwI1vEuDoyWfdcOWnHS9d2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqlrqZv7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 831A1C4CECD;
	Wed, 20 Nov 2024 07:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732086075;
	bh=oaMqr8221d4dNAMOE6HnSj3j2CboaMXhg2FJ5tzAdbY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=rqlrqZv7uevf56YLjIwAkzK9jGfNiy2qtIbXixOLNUtWd04YGaJ8lWmBbXDGSHb+P
	 yQIh83RU7QhL8pW4ujcTlwctpgVTHofwBFzyYihbiAixj7nHG/vC74F3qlmalEl9qy
	 xjic3xJEqzhiaaDZ06YqPsSbGrGwutunRahjItcxJW/x9j011Gcp0UKJ4mlkfNToFb
	 4H5YqU02Ql8RCb4kdKUWKGOhhhVkV39Z5k4sX8HYjpIo3thhv+HzCt8ac+yZjBmmXr
	 cwypaGaogAVecID6ko9KQIgfIV1MfZEmsJ/YNTopjN3vW5UqAT4QXmS8Xj5jchhwFz
	 ZP+yOdwcneGjg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDFBD6E2CD;
	Wed, 20 Nov 2024 07:01:15 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v2 0/5] Add A5 SoC PLLs and Peripheral clock
Date: Wed, 20 Nov 2024 15:01:12 +0800
Message-Id: <20241120-a5-clk-v2-0-1208621e961d@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADiJPWcC/zXMQQqDMBCF4avIrDsliRFqV71HcRGnow5VU5ISW
 iR3byq4/B+Pb4PIQTjCtdogcJIofi1hThXQ5NaRUR6lwShjVas1ugZpfmLdkG0d9bVlDeX8Cjz
 IZ4fuXelJ4tuH7+4m/V8Pwh5E0qiwYTZkB92rC93cMvtR6Ex+gS7n/AMsf8MongAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732086073; l=2344;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=oaMqr8221d4dNAMOE6HnSj3j2CboaMXhg2FJ5tzAdbY=;
 b=MHBCAgBZtPFPVVjh1j0QLRkcYUREgMvXITQQxxmm3yCDm2XyITssD8oM3P69MCTmYq67mb4qX
 KFFX1xf0fW8DaMTW6YjKZWpEATXe9LL36uO6HvP/XPFtu8lSz0MOW/o
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
FCLK_DIV7_DIV, FCLK_DIV7, CLKID_SYS_MMC_PCLK, CLKID_SYS_CPU_CTRL,
CLKID_SYS_IRQ_CTRL, CLKID_SYS_GIC, CLKID_SYS_BIG_NIC, CLKID_AXI_SYS_NIC,
and CLKID_AXI_CPU_DMC.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Changes in v2:
- Move some sys clock and axi clock from peripheral to scmi impletement.
- Remove  ARM_SCMI_PROTOCOL in Kconfig and correct name A5 but not A4.
- Add two optional clock inputs for the peripheral(ddr pll and clk-measure)
- Make some changes and adjustments according to suggestions.
- Link to v1: https://lore.kernel.org/r/20240914-a5-clk-v1-0-5ee2c4f1b08c@amlogic.com

---
Chuan Liu (5):
      dt-bindings: clock: add Amlogic A5 PLL clock controller
      dt-bindings: clock: add Amlogic A5 SCMI clock controller support
      dt-bindings: clock: add Amlogic A5 peripherals clock controller
      clk: meson: add support for the A5 SoC PLL clock
      clk: meson: add A5 clock peripherals controller driver

 .../clock/amlogic,a5-peripherals-clkc.yaml         |  130 ++
 .../bindings/clock/amlogic,a5-pll-clkc.yaml        |   62 +
 drivers/clk/meson/Kconfig                          |   27 +
 drivers/clk/meson/Makefile                         |    2 +
 drivers/clk/meson/a5-peripherals.c                 | 1387 ++++++++++++++++++++
 drivers/clk/meson/a5-pll.c                         |  543 ++++++++
 drivers/clk/meson/clk-regmap.h                     |   17 +
 .../clock/amlogic,a5-peripherals-clkc.h            |  132 ++
 include/dt-bindings/clock/amlogic,a5-pll-clkc.h    |   24 +
 include/dt-bindings/clock/amlogic,a5-scmi-clkc.h   |   44 +
 10 files changed, 2368 insertions(+)
---
base-commit: 961101258aa2da34b032ea21f32599a895448996
change-id: 20240911-a5-clk-35c49acb34e1

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



