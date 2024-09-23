Return-Path: <linux-kernel+bounces-334071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A24B97D24A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3587DB22381
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263636E2AE;
	Fri, 20 Sep 2024 08:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmQdpQUW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765AE18EB1;
	Fri, 20 Sep 2024 08:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820029; cv=none; b=Im22ePhE4orb3SJOLoRfxY3jhgf7GY67CkzOyAI6qraozb7mke7DMmdd7bhwgSDZdtauhSn1W8wrXXavMQn+fH1jzgULbzZYSz4mDjjGOMlcZw8HE+oTKHJoDLfFUZ6Owm3HmHfKJvjcqRO7VjTpSMJ5znCPzZ5EYCm3cPznstc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820029; c=relaxed/simple;
	bh=9hmMsURfWQvQALeUJoUpEIlJ5bSjiG5NcrH3pWDEfjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rYndd45kF8wMepeTD/5HFFxxboQSgqM+Tf7grnDGoxCABy6luVqDJlWElAiRFbt+KD7j1zMgL0MXlqfX2299OMaEcZ3sy887bmsFr06bm4frNpbY6u/AoNPJf5uTfuoq2VxquFhJbPjiOB/tOmDrB2l17szne5qE21j0JlPEn4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmQdpQUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD219C4CEC5;
	Fri, 20 Sep 2024 08:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726820028;
	bh=9hmMsURfWQvQALeUJoUpEIlJ5bSjiG5NcrH3pWDEfjA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=AmQdpQUW4VQVNjjs1Mab7sJO5EUTftLM5IK8CyRi3A53qii1LSKP1sQeD4llp4VHV
	 r0vEKZ46AJSoWj7i7/7LvGae6i8svaLxVvXUy5o5fg/RsTtXcrJsYdHci3mYq+Irqp
	 n04RfQyEf8vdIlOjJiPSI3Lb2Hceh8iZexI4SVLh0xp2QyDk+m70IqJTQyq+nhUzTK
	 xVSJpQ1DGPSYQHA3OKNoOq0vD/5cNtXpmfF1HLTaE5IdV0Buj3IQB1JtkT3awcKns+
	 1NCayfrra1d4ppsJJw2mcTusLiAXS7Upwem11mwWY5e0ynKeCHq4D9TLxeOgozAW3m
	 7hQgSgikkZ0Mg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCAFCF58DD;
	Fri, 20 Sep 2024 08:13:48 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Fri, 20 Sep 2024 16:13:13 +0800
Subject: [PATCH] clk: meson: pll: Update the meson_clk_pll_init execution
 judgment logic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-optimize_pll_flag-v1-1-c90d84a80a51@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAJgu7WYC/x3M0QpAMBSA4VfRubZixOFVJC07m1PD2iSRd7dcf
 hf//0CkwBShzx4IdHLkfUso8wzmRW2WBOtkkIWsi65EsfuDV75p8s5NxikrmhYVopaVQQmp84E
 MX/9zGN/3A4BHfd1jAAAA
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726820026; l=2429;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=Bxi0pv+eCzIxvYRz/WWiwYenjJWhGAFp4yX+VQVeYR0=;
 b=SHfpgZJ0kfXUg89lZ7xFZh4+atixE7c7aAQxxNKPJ4Pj5PBehGSJ/C39ZYFB1y/QIK1IadLCz
 53bEMsO8fveCj1E6BYhN0C3BkiwU/wYlJIhy/UB7GJvLoLoI4Jb/f73
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

The hardware property of PLL determines that PLL can only be enabled
after PLL has been initialized. If PLL is not initialized, the
corresponding lock bit will not be set to 1, resulting in
meson_clk_pll_is_enabled() returning "false".

Therefore, if PLL is already enabled, there is no need to repeat
initialization, and the judgment "CLK_MESON_PLL_NOINIT_ENABLED" in
meson_clk_pll_init() appears redundant.

---
The hardware property of PLL determines that PLL can only be enabled
after PLL has been initialized. If PLL is not initialized, the
corresponding lock bit will not be set to 1, resulting in
meson_clk_pll_is_enabled() returning "false".

Therefore, if PLL is already enabled, there is no need to repeat
initialization, and the judgment "CLK_MESON_PLL_NOINIT_ENABLED" in
meson_clk_pll_init() appears redundant.

In actual application scenarios, PLL configuration is determined during
the bootloader phase. If PLL has been configured during the bootloader
phase, you need to add a flag to the kernel to avoid PLL
re-initialization, which will increase the coupling between the kernel
and the bootloader.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 drivers/clk/meson/clk-pll.c | 3 +--
 drivers/clk/meson/clk-pll.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index 89f0f04a16ab..8df2add40b57 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -316,8 +316,7 @@ static int meson_clk_pll_init(struct clk_hw *hw)
 	 * Keep the clock running, which was already initialized and enabled
 	 * from the bootloader stage, to avoid any glitches.
 	 */
-	if ((pll->flags & CLK_MESON_PLL_NOINIT_ENABLED) &&
-	    meson_clk_pll_is_enabled(hw))
+	if (meson_clk_pll_is_enabled(hw))
 		return 0;
 
 	if (pll->init_count) {
diff --git a/drivers/clk/meson/clk-pll.h b/drivers/clk/meson/clk-pll.h
index 949157fb7bf5..cccbf52808b1 100644
--- a/drivers/clk/meson/clk-pll.h
+++ b/drivers/clk/meson/clk-pll.h
@@ -28,7 +28,6 @@ struct pll_mult_range {
 	}
 
 #define CLK_MESON_PLL_ROUND_CLOSEST	BIT(0)
-#define CLK_MESON_PLL_NOINIT_ENABLED	BIT(1)
 
 struct meson_clk_pll_data {
 	struct parm en;

---
base-commit: 0ef513560b53d499c824b77220c537eafe1df90d
change-id: 20240918-optimize_pll_flag-678a88d23f82

Best regards,
-- 
Chuan Liu <chuan.liu@amlogic.com>



