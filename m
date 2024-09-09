Return-Path: <linux-kernel+bounces-321123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B39959714E6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E57284B11
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E47A1B3F2D;
	Mon,  9 Sep 2024 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpiYI1LE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90316DF58;
	Mon,  9 Sep 2024 10:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876557; cv=none; b=FbW93uh/sjc8WVzDc4d8OFr6oFHjT6yc69+R7FUXe8z+Bjqw8txOmtEJTq07jcEZcIB3E3ZsJTvXkzVB3Sw5hbUm4zXfql7SWcwyrsz9E/j2RopX/K8TyDCpNe0j3tCVaMMMobdSrKiD1VHNijFdwlBfF00RVUoyVS0urS9T+84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876557; c=relaxed/simple;
	bh=wNROTOGwTrtcI0H20f0EmINCmCNdwFiZLjQMJFcLHU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HfXMH4X2+C7tjhXYaKhNHXG4umqn4LejkpMHvbXixfWombaWeBBjJP0g6i39JZnMycVqLmoZh1peHFrM+b0P+qIygMp+mfatRVHxv+4bMBe/n0mai8x3cCb+Daynp6mbuS6h+foIleXLldhQrjHudhd6+pCvQUr1CifWKQCG12k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpiYI1LE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A638C4CECB;
	Mon,  9 Sep 2024 10:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725876557;
	bh=wNROTOGwTrtcI0H20f0EmINCmCNdwFiZLjQMJFcLHU0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gpiYI1LEY/2NHjn7vKGGHqTn5IIYP40L/Emxy8Ltkz1ktpF9M83Xausz4RkMPJ3nk
	 7wm/RhYdoooo4Uposni120xm+xloKvICJbyJ3IOVzixIvtbe2LKRKOnK3o9/VVTHFX
	 cFZKliUsKLg/q5aSHymagdVrWm70X6btCPpbm9LrkhXJmlzqQHmvCV3JWt5twrpyCh
	 8JrgcFM7DTgo8y++L3LP0cIlYTNVFVp7ErJvXODUMPHrVggdeC6BPsxm0N0hCQgqqM
	 SJ71RUlfjPFw5sEMpy2QorM+NUxjBZaXBtrfNrjOCniWW3DXjG9Ewwm3freOhHdcsv
	 qjWRQNgnKfXEQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE36ECE57A;
	Mon,  9 Sep 2024 10:09:17 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Mon, 09 Sep 2024 18:08:57 +0800
Subject: [PATCH v3 2/3] clk: meson: c3: pll: fix frac maximum value for
 hifi_pll
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-fix_clk-v3-2-a6d8f6333c04@amlogic.com>
References: <20240909-fix_clk-v3-0-a6d8f6333c04@amlogic.com>
In-Reply-To: <20240909-fix_clk-v3-0-a6d8f6333c04@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725876555; l=770;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=I33Vhd+oqJKtNl4x++Y8xPKvaKodnZowE3DBu//z/PA=;
 b=sUDSMpQF9WTheM2ifxOy7eEX8CY4oBwIkOs0u9IEtYYRpSvEcQ5GG9sxdrCKUWqGbm9QBL96f
 zfj8XzUBaAOC1ifMGVa+iIc+WFvmq83fhWx6zjlCWHOclqLVsF5v7WT
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

The fractional denominator of C3's hifi_pll fractional multiplier is
fixed to 100000.

Fixes: 8a9a129dc565 ("clk: meson: c3: add support for the C3 SoC PLL clock")
Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 drivers/clk/meson/c3-pll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/meson/c3-pll.c b/drivers/clk/meson/c3-pll.c
index 32bd2ed9d304..35fda31a19e2 100644
--- a/drivers/clk/meson/c3-pll.c
+++ b/drivers/clk/meson/c3-pll.c
@@ -361,6 +361,7 @@ static struct clk_regmap hifi_pll_dco = {
 		.range = &c3_gp0_pll_mult_range,
 		.init_regs = c3_hifi_init_regs,
 		.init_count = ARRAY_SIZE(c3_hifi_init_regs),
+		.frac_max = 100000,
 	},
 	.hw.init = &(struct clk_init_data) {
 		.name = "hifi_pll_dco",

-- 
2.42.0



